from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Video, Quizzes, QuizQuestions, Comments, CommentInfo, Profile, ToDos


class VideoSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = Video
        fields = ('title', 'url', 'thumbnail_filename')


class ProfileSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = Profile


class UserSerializer(serializers.HyperlinkedModelSerializer):
    profile = ProfileSerializer(source='User', many=True)

    class Meta:
        model = User
        fields = ('url', 'username', 'id', 'profile')


class QuizQuestionSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = QuizQuestions
        fields = ('quiz_id', 'question_text', 'answer',
                  'correct_answer', 'false_answer')


class QuizSerializer(serializers.HyperlinkedModelSerializer):
    questions = QuizQuestionSerializer(source='quiz', many=True)

    class Meta:
        model = Quizzes
        fields = ('title', 'url', 'video_id', 'questions')


class CommentInfoSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = CommentInfo
        fields = ('url', 'text', 'date_added', 'owner',)


class CommentSerializer(serializers.HyperlinkedModelSerializer):
    comments = CommentInfoSerializer(source='comment_parent', many=True)

    class Meta:
        model = Comments
        fields = ('url', 'parent_id', 'comments')


class VideoDataSerializer(serializers.HyperlinkedModelSerializer):
    quiz_url = serializers.HyperlinkedIdentityField(view_name='quizzes-detail')
    comments = CommentSerializer(source='video_parent', many=True)

    class Meta:
        model = Video
        fields = ('title', 'description', 'thumbnail_filename',
                  'hls_url', 'rtmp_server_url', 'rtmp_stream_name',
                  'quiz_url', 'comments')


class ToDosSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = ToDos
        fields = ('user_id', 'icon_id', 'text', 'date_added', 'date_completed')
