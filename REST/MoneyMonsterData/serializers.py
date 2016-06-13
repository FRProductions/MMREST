from rest_framework import serializers

from .models import *


class VideoSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = Video
        fields = ('title', 'url', 'thumbnail_filename')


class ProfileSerializer(serializers.HyperlinkedModelSerializer):
    # TODO: for this user, get counts from different models:
    #   quizzes passed, quizzes failed, todo count, discussion count
    todo_count = serializers.IntegerField(source='todo_parent.count', read_only=True)
    discussion_count = serializers.IntegerField(source='comment_parent.count', read_only=True)
    quiz_passed = serializers.IntegerField(source='quiz_parent.count', read_only=True)

    class Meta:
        model = User
        fields = ('todo_count', 'discussion_count', 'quiz_passed', 'username', )


class QuizResultsSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = QuizResult


class ToDosSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = ToDo
        fields = ('url', 'user', 'icon', 'text', 'date_added', 'date_completed')


class UserSerializer(serializers.HyperlinkedModelSerializer):
    to_do = ToDosSerializer(source='todo_parent', many=True)
    quiz_results = QuizResultsSerializer(source='quiz_parent', many=True)

    class Meta:
        model = User
        fields = ('url', 'username', 'id', 'quiz_results', 'to_do')


class QuizQuestionSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = QuizQuestion
        fields = ('question_text', 'answer',
                  'correct_message', 'false_message')


class QuizSerializer(serializers.HyperlinkedModelSerializer):
    questions = QuizQuestionSerializer(source='quiz', many=True)

    class Meta:
        model = Quiz
        fields = ('url', 'title', 'questions')


class CommentLikeSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = CommentLike
        fields = ('user', 'comment')


class CommentSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')
    like_count = serializers.IntegerField(source='like_parent.count', read_only=True)

    class Meta:
        model = Comment
        fields = ('url', 'text', 'date_added', 'owner', 'like_count')


class VideoDataSerializer(serializers.HyperlinkedModelSerializer):
    quiz = QuizSerializer(source='video', many=True)
    comments = CommentSerializer(many=True)

    class Meta:
        model = Video
        fields = ('id', 'title', 'description', 'thumbnail_filename',
                  'hls_url', 'rtmp_server_url', 'rtmp_stream_name',
                  'quiz', 'comments')

