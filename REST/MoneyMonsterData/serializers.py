from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Video, Quizzes, QuizQuestions, Comments, CommentInfo


class VideoSerializer(serializers.HyperlinkedModelSerializer):
    # quiz = serializers.HyperlinkedIdentityField(view_name='quizzes-detail')
    # comments_info = serializers.HyperlinkedIdentityField(view_name='comments-list')
    # comments = serializers.HyperlinkedIdentityField(view_name='comments-detail')

    class Meta:
        model = Video
        fields = ('title', 'url', 'thumbnailUrl')


class UserSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = User
        fields = ('url', 'username', 'id', )


class QuizQuestionSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = QuizQuestions
        fields = ('quiz_id', 'question_text', 'answer_one', 'answer_two', 'answer_three', 'answer_four',
                  'correct_answer')


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
    quiz = serializers.HyperlinkedIdentityField(view_name='quizzes-detail')
    comments = CommentSerializer(source='video_parent', many=True)

    class Meta:
        model = Video
        fields = ('title', 'url', 'ios', 'android', 'quiz',
                  'comments')