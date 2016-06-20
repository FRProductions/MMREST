from django.apps import apps
from django.core.exceptions import ObjectDoesNotExist
from rest_framework import serializers

from .models import *


class QuizResultsSerializer(serializers.HyperlinkedModelSerializer):
    quiz_score = serializers.ReadOnlyField(source="passed")

    class Meta:
        model = QuizResult
        fields = ('quiz_score', )


class ProfileSerializer(serializers.HyperlinkedModelSerializer):
    todo_count = serializers.IntegerField(source='todo_set.count', read_only=True)
    discussion_count = serializers.IntegerField(source='comment_set.count', read_only=True)
    quiz_results = QuizResultsSerializer(source='quizresult_set', many=True)

    class Meta:
        model = User
        fields = ('todo_count', 'discussion_count', 'quiz_results', 'username')


class ToDosSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = ToDo
        fields = ('url', 'user', 'icon', 'text', 'date_added', 'date_completed')


class UserSerializer(serializers.HyperlinkedModelSerializer):
    to_do = ToDosSerializer(source='todo_set', many=True)
    quiz_results = QuizResultsSerializer(source='quizresult_set', many=True)

    class Meta:
        model = User
        fields = ('url', 'username', 'id', 'quiz_results', 'to_do')


class QuizQuestionSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = QuizQuestion
        fields = ('question_text', 'answer',
                  'correct_message', 'false_message')


class QuizSerializer(serializers.HyperlinkedModelSerializer):
    questions = QuizQuestionSerializer(source='quizquestion_set', many=True)

    class Meta:
        model = Quiz
        fields = ('url', 'title', 'questions')


class CommentLikeSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = CommentLike
        fields = ('user', 'comment')


class CommentSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='user.username')
    like_count = serializers.IntegerField(source='commentlike_set.count', read_only=True)
    content_type = serializers.CharField(source='content_type.model')

    class Meta:
        model = Comment
        fields = ('url', 'content_type', 'object_id', 'text', 'date_added', 'owner', 'like_count')

    def validate_content_type(self, value):
        """
        Field Validation: Check that the content_type serialized value is a valid model name for this app
        """
        try:
            self.get_app_model(value)
            return value
        except LookupError:
            raise serializers.ValidationError("not a valid model name")

    def validate(self, data):
        """
        General Validation: Check that the object_id refers to a valid object.
        """
        model_name = data['content_type']['model']
        model = self.get_app_model(model_name)  # already validated
        object_id = data['object_id']
        try:
            model.objects.get(id=object_id)
        except ObjectDoesNotExist:
            raise serializers.ValidationError("no %s found with id %i" % (model_name, object_id))
        return data

    def create(self, validated_data):
        """
        Replace 'content_type' model name with real ContentType object
        """
        model = self.get_app_model(validated_data['content_type']['model'])
        validated_data['content_type'] = ContentType.objects.get_for_model(model)
        return Comment.objects.create(**validated_data)

    def update(self, instance, validated_data):
        """
        Replace 'content_type' model name with real ContentType object
        """
        model = self.get_app_model(validated_data['content_type']['model'])
        validated_data['content_type'] = ContentType.objects.get_for_model(model)
        return super(CommentSerializer, self).update(instance, validated_data)

    def get_app_model(self, model_name):
        """
        Get ContentType object for the given app model name
        """
        app_label = self.Meta.model._meta.app_label                         # label of this app
        return apps.get_model(app_label=app_label, model_name=model_name)   # Raises LookupError if model not found


class VideoStatusSerializer(serializers.HyperlinkedModelSerializer):
    user = serializers.HyperlinkedRelatedField(view_name='user-detail', read_only=True, required=False)

    class Meta:
        model = VideoStatus
        fields = ('user', 'rating', 'completed')


class VideoBaseSerializer(serializers.HyperlinkedModelSerializer):
    user_video_completed = serializers.SerializerMethodField()
    user_video_status = serializers.HyperlinkedIdentityField(view_name='videostatus-detail', read_only=True)
    user_quiz_passed = serializers.SerializerMethodField()

    """
    Looks up the VideoStatus record for the current user and video and returns the 'completed' boolean.
    """
    def get_user_video_completed(self, obj):

        # get current user and video
        user = self.context['request'].user
        if not user.is_authenticated():
            return "not authenticated"
        video = obj

        # lookup VideoStatus instance, if it exists
        try:
            video_status = VideoStatus.objects.get(user=user, video=video)
            return video_status.completed
        except VideoStatus.DoesNotExist:
            return False

    """
    Looks up the QuizResult record for the current user and video/quiz and returns the 'passed' boolean.
    """
    def get_user_quiz_passed(self, obj):
        # get current user
        user = self.context['request'].user
        if not user.is_authenticated():
            return "not authenticated"

        # get quiz related to video
        try:
            quiz = Quiz.objects.get(video=obj)
        except Quiz.DoesNotExist:
            return None

        # lookup QuizResult instance, if it exists
        try:
            quiz_result = QuizResult.objects.get(user=user, quiz=quiz)
            return quiz_result.passed()
        except QuizResult.DoesNotExist:
            return None


class VideoSummarySerializer(VideoBaseSerializer):
    class Meta:
        model = Video
        fields = ('url', 'title', 'thumbnail_filename', 'rating', 'user_video_completed', 'user_video_status',
                  'user_quiz_passed')


class VideoDetailSerializer(VideoBaseSerializer):
    quiz = QuizSerializer(source='quiz_set', many=True)
    comments = CommentSerializer(many=True)

    class Meta:
        model = Video
        fields = ('url', 'id', 'title', 'description', 'thumbnail_filename',
                  'hls_url', 'rtmp_server_url', 'rtmp_stream_name',
                  'rating', 'user_video_completed', 'user_video_status', 'user_quiz_passed',
                  'quiz', 'comments')
