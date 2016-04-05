from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Video, Quizzes, QuizQuestions, Comments


class VideoSerializer(serializers.HyperlinkedModelSerializer):
    quiz = serializers.HyperlinkedIdentityField(view_name='quizzes-detail')
    comments_info = serializers.HyperlinkedIdentityField(view_name='comments-list')
    comments_edit = serializers.HyperlinkedIdentityField(view_name='comments-detail')

    class Meta:
        model = Video
        fields = ('title', 'url', 'ios', 'android', 'quiz', 'comments_info',
                  'comments_edit')


class UserSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = User
        fields = ('url', 'username', 'id', )


class QuizQuestionSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = QuizQuestions
        fields = ('url', 'quiz_id', 'question_text', 'answer_one', 'answer_two', 'answer_three', 'answer_four',
                  'correct_answer')


class QuizSerializer(serializers.HyperlinkedModelSerializer):
    # questions = QuizQuestionSerializer(many=False, read_only=True)

    class Meta:
        model = Quizzes
        fields = ('title', 'url', 'video_id', 'quiz')
        depth = 3


class CommentSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Comments
        fields = ('url', 'parent_id', 'owner', 'text', 'date_added', 'owner')
