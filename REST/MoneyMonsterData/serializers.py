from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Video, Quizzes, QuizQuestions, Comments


class VideoSerializer(serializers.HyperlinkedModelSerializer):
    quiz_info = serializers.HyperlinkedIdentityField(view_name='quizzes-list')
    quiz_edit = serializers.HyperlinkedIdentityField(view_name='quizzes-detail')
    comments_info = serializers.HyperlinkedIdentityField(view_name='comments-list')
    comments_edit = serializers.HyperlinkedIdentityField(view_name='comments-detail')

    class Meta:
        model = Video
        fields = ('title', 'url', 'ios', 'android', 'quiz_info', 'quiz_edit', 'comments_info',
                  'comments_edit')


class UserSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = User
        fields = ('url', 'username', 'id', )


class QuizSerializer(serializers.HyperlinkedModelSerializer):
    questions_info = serializers.HyperlinkedIdentityField(view_name='quizquestions-list')
    questions_edit = serializers.HyperlinkedIdentityField(view_name='quizquestions-detail')

    class Meta:
        model = Quizzes
        fields = ('title', 'url', 'video_id', 'questions_info', 'questions_edit')


class QuizQuestionSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = QuizQuestions
        fields = ('url', 'quiz_id', 'question_text', 'answer_one', 'answer_two', 'answer_three', 'answer_four',
                  'correct_answer')


class CommentSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Comments
        fields = ('url', 'parent_id', 'owner', 'text', 'date_added', 'owner')
