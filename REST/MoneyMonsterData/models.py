from django.db import models
from django.contrib.auth.models import User
from django.core.validators import MinValueValidator, MaxValueValidator


class Video(models.Model):
    title = models.CharField(max_length=255)
    ios = models.CharField(max_length=255)
    android = models.CharField(max_length=255)

    def __str__(self):
        return self.title + ' page'


class VideoStatus(models.Model):
    video_id = models.ForeignKey(Video)
    user_id = models.ForeignKey(User)
    rating = models.IntegerField(validators=[MinValueValidator(1), MaxValueValidator(5)])
    eye_status = models.BooleanField(default=False)
    check_status = models.BooleanField(default=False)


class Comments(models.Model):
    parent_id = models.ForeignKey(Video)
    owner = models.ForeignKey('auth.User', related_name='comments')
    text = models.TextField(blank=False, max_length=1000)
    date_added = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.parent_id.title + ': ' + self.text

    class Meta:
        ordering = ('date_added',)


class CommentLikes(models.Model):
    user_id = models.ForeignKey(User)
    comment_id = models.ForeignKey(Comments)
    liked = models.BooleanField(default=False)


class ToDos(models.Model):
    user_id = models.ForeignKey(User)
    icon_id = models.CharField(max_length=255)
    text = models.TextField(blank=False, max_length=1000)
    date_added = models.DateTimeField(auto_now_add=True)
    date_completed = models.DateTimeField(auto_now_add=True)


class Quizzes(models.Model):
    video_id = models.ForeignKey(Video)
    title = models.CharField(max_length=255)

    def __str__(self):
        return 'Video:' + self.video_id.title + ' - Quiz: ' + self.title


class QuizQuestions(models.Model):
    quiz_id = models.ForeignKey(Quizzes, related_name='quiz')
    question_text = models.TextField(blank=False, max_length=1000)
    answer_one = models.TextField(blank=False, max_length=500)
    answer_two = models.TextField(blank=False, max_length=500)
    answer_three = models.TextField(blank=False, max_length=500)
    answer_four = models.TextField(blank=False, max_length=500)
    correct_answer = models.IntegerField(validators=[MinValueValidator(1), MaxValueValidator(4)])

    def __str__(self):
        return 'Question: ' + self.quiz_id.title + ': ' + self.question_text


class QuizAnswers(models.Model):
    quiz_question_id = models.ForeignKey(QuizQuestions)
    user_id = models.ForeignKey(User)
    user_answer = models.IntegerField(validators=[MinValueValidator(1), MaxValueValidator(4)])
    explanation_text = models.TextField(blank=False, max_length=1000)
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return 'Question: ' + self.quiz_question_id.question_text


class QuizResults(models.Model):
    quiz_id = models.ForeignKey(Quizzes)
    user_id = models.ForeignKey(User)
    score = models.IntegerField(validators=[MinValueValidator(0), MaxValueValidator(100)])
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.user_id.username + ' results'