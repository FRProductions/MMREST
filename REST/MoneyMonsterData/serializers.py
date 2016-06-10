from rest_framework import serializers
from django.contrib.auth.models import User
from .models import *


class VideoSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = Video
        fields = ('title', 'url', 'thumbnail_filename')


class ProfileSerializer(serializers.HyperlinkedModelSerializer):
    # TODO: for this user, get counts from different models:
    #   quizzes passed, quizzes failed, todo count, discussion count

    class Meta:
        model = Profile


class QuizResultsSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = QuizResult


class ToDosSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = ToDo
        fields = ('url', 'user_id', 'icon_id', 'text', 'date_added', 'date_completed')


class UserSerializer(serializers.HyperlinkedModelSerializer):
    to_do = ToDosSerializer(source='todo_parent', many=True)
    profile = ProfileSerializer(source='User', many=True)
    quiz_results = QuizResultsSerializer(source='quiz_parent', many=True)

    class Meta:
        model = User
        fields = ('url', 'username', 'id', 'profile', 'quiz_results', 'to_do')


class QuizQuestionSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = QuizQuestion
        fields = ('question_text', 'answer',
                  'correct_answer', 'false_answer')


class QuizSerializer(serializers.HyperlinkedModelSerializer):
    questions = QuizQuestionSerializer(source='quiz', many=True)

    class Meta:
        model = Quiz
        fields = ('url', 'title', 'questions')


class CommentLikeSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = CommentLike
        fields = ('user_id', 'comment_id')


class CommentSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')
    like_count = serializers.IntegerField(source='comment_parent.count', read_only=True)

    class Meta:
        model = Comment
        fields = ('video_id', 'text', 'date_added', 'owner', 'like_count')


class VideoDataSerializer(serializers.HyperlinkedModelSerializer):
    quiz = QuizSerializer(source='video', many=True)
    comment = CommentSerializer(source='video_parent', many=True)

    class Meta:
        model = Video
        fields = ('title', 'description', 'thumbnail_filename',
                  'hls_url', 'rtmp_server_url', 'rtmp_stream_name',
                  'quiz', 'comment')

