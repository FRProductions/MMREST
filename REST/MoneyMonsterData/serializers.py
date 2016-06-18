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
    url = serializers.HyperlinkedRelatedField(
        source='video', view_name='videostatus-detail', read_only=True)

    class Meta:
        model = VideoStatus
        fields = ('url', 'rating', 'completed')


class VideoSummarySerializer(serializers.HyperlinkedModelSerializer):
    user_video_status = VideoStatusSerializer(source='videostatus_set', many=True)

    class Meta:
        model = Video
        fields = ('url', 'title', 'thumbnail_filename', 'rating', 'user_video_status')


class VideoDetailSerializer(serializers.HyperlinkedModelSerializer):
    quiz = QuizSerializer(source='quiz_set', many=True)
    comments = CommentSerializer(many=True)
    user_video_status = VideoStatusSerializer(source='videostatus_set', many=True)

    class Meta:
        model = Video
        fields = ('url', 'id', 'title', 'description', 'thumbnail_filename',
                  'hls_url', 'rtmp_server_url', 'rtmp_stream_name',
                  'rating', 'user_video_status', 'quiz', 'comments')
