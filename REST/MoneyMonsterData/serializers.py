from django.utils import timezone

from django.apps import apps
from django.core.exceptions import ObjectDoesNotExist
from django.core.urlresolvers import reverse
from rest_framework import serializers

from .models import QUIZ_PASS_PERCENTAGE
from .models import User, Video, VideoStatus, Quiz, QuizQuestion, Comment, ToDo, CommentLike, ContentType, QuizResult


class ProfileSerializer(serializers.HyperlinkedModelSerializer):
    completed_todo_count = serializers.SerializerMethodField()
    comment_count = serializers.IntegerField(source='comment_set.count', read_only=True)
    passed_quiz_count = serializers.SerializerMethodField()
    failed_quiz_count = serializers.SerializerMethodField()

    class Meta:
        model = User
        fields = ('completed_todo_count', 'comment_count', 'passed_quiz_count', 'failed_quiz_count', 'username')

    def get_completed_todo_count(self, user):
        return ToDo.objects.filter(user=user, completed=True).count()

    def get_passed_quiz_count(self, user):
        return QuizResult.objects.filter(user=user, percent_correct__gte=QUIZ_PASS_PERCENTAGE).count()

    def get_failed_quiz_count(self, user):
        return QuizResult.objects.filter(user=user, percent_correct__lt=QUIZ_PASS_PERCENTAGE).count()


class ToDosSerializer(serializers.HyperlinkedModelSerializer):
    date_completed = serializers.DateTimeField(read_only=True)

    class Meta:
        model = ToDo
        fields = ('url', 'icon', 'text', 'date_added', 'completed', 'date_completed')

    def create(self, validated_data):
        if validated_data['completed']:
            validated_data['date_completed'] = timezone.now()
        return super(ToDosSerializer, self).create(validated_data)

    def update(self, instance, validated_data):
        if validated_data['completed']:
            validated_data['date_completed'] = timezone.now()
        return super(ToDosSerializer, self).update(instance, validated_data)


class UserSerializer(serializers.HyperlinkedModelSerializer):
    to_do = ToDosSerializer(source='todo_set', many=True)

    class Meta:
        model = User
        fields = ('url', 'username', 'id', 'to_do')


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
    parent_url = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = Comment
        fields = ('url', 'parent_url', 'content_type', 'object_id', 'text', 'date_added', 'owner', 'like_count')

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

    def get_parent_url(self, comment):
        """
        Create a parent url based on the parent object type
        """
        parent_object = comment.content_object
        if isinstance(parent_object, Video):
            absolute_path = reverse('video-detail', kwargs={'pk': parent_object.id})
            return self.context['request'].build_absolute_uri(absolute_path)
        else:
            raise Exception('Unexpected type of comment parent object')


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
    def get_user_video_completed(self, video):

        # get current user
        user = self.context['request'].user
        if not user.is_authenticated():
            return "not authenticated"

        # lookup VideoStatus instance, if it exists
        try:
            video_status = VideoStatus.objects.get(user=user, video=video)
            return video_status.completed
        except VideoStatus.DoesNotExist:
            return False

    """
    Looks up the QuizResult record for the current user and video/quiz and returns the 'passed' boolean.
    """
    def get_user_quiz_passed(self, video):

        # get current user
        user = self.context['request'].user
        if not user.is_authenticated():
            return "not authenticated"

        # get quiz related to video
        try:
            quiz = Quiz.objects.get(video=video)
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
        fields = ('url', 'id', 'title', 'thumbnail_filename', 'rating', 'user_video_completed', 'user_video_status',
                  'user_quiz_passed')


class VideoDetailSerializer(VideoBaseSerializer):
    quiz = QuizSerializer(source='quiz_set', many=True)
    comments = serializers.SerializerMethodField()

    class Meta:
        model = Video
        fields = ('url', 'id', 'title', 'description', 'thumbnail_filename', 'todo_text', 'todo_icon',
                  'hls_url', 'rtmp_server_url', 'rtmp_stream_name',
                  'rating', 'user_video_completed', 'user_video_status', 'user_quiz_passed',
                  'quiz', 'comments')

    def get_comments(self, video):
        queryset = video.comments.all().order_by('-date_added')[:20]  # order newest to oldest, and take first chunk
        queryset = reversed(queryset)                                 # reverse selected chunk so it's oldest to newest
        serializer = CommentSerializer(instance=queryset, many=True, context={'request': self.context['request']})
        return serializer.data
