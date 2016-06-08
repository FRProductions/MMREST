from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Video, Quizzes, QuizQuestions, Comment, Profile, ToDo, QuizResults


class VideoSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = Video
        fields = ('title', 'url', 'thumbnail_filename')


class ProfileSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = Profile


class QuizResultsSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = QuizResults


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
        model = QuizQuestions
        fields = ('question_text', 'answer',
                  'correct_answer', 'false_answer')


class QuizSerializer(serializers.HyperlinkedModelSerializer):
    questions = QuizQuestionSerializer(source='quiz', many=True)

    class Meta:
        model = Quizzes
        fields = ('url', 'title', 'questions')


class CommentSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Comment
        fields = ('url', 'video_id', 'text', 'date_added', 'owner')


class VideoDataSerializer(serializers.HyperlinkedModelSerializer):
    quiz = QuizSerializer(source='video', many=True)
    comment = CommentSerializer(source='video_parent', many=True)

    class Meta:
        model = Video
        fields = ('title', 'description', 'thumbnail_filename',
                  'hls_url', 'rtmp_server_url', 'rtmp_stream_name',
                  'quiz', 'comment')

