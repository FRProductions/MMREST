from rest_framework import serializers
from django.contrib.auth.models import User
from .models import *


class VideoSerializer(serializers.HyperlinkedModelSerializer):
    quiz = serializers.HyperlinkedIdentityField(view_name='quiz-list')

    class Meta:
        model = Video
        fields = ('title', 'url', 'ios', 'android', 'quiz')


class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ('url', 'username',)


class QuizSerializer(serializers.HyperlinkedModelSerializer):
    questions = serializers.HyperlinkedIdentityField(view_name='quiz-questions')

    class Meta:
        model = Quizzes
        fields = ('title', 'url', 'video_id', 'questions')


class QuizQuestionSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = QuizQuestions
        fields = ('url', 'quiz_id', 'question_text', 'answer_one', 'answer_two', 'answer_three', 'answer_four',
                  'correct_answer')

