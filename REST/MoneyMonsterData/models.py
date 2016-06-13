from django.db import models
from django.contrib.auth.models import User
from django.core.validators import MinValueValidator, MaxValueValidator
from django.dispatch import receiver
from django.db.models.signals import post_save


class Video(models.Model):
    title = models.CharField(max_length=255)
    description = models.CharField(max_length=255)
    thumbnail_filename = models.CharField(max_length=255)
    hls_url = models.CharField(max_length=255)
    rtmp_server_url = models.CharField(max_length=255)
    rtmp_stream_name = models.CharField(max_length=255)

    def __str__(self):
        return self.title + ' video'


class VideoStatus(models.Model):
    video = models.ForeignKey(Video)
    user = models.ForeignKey(User)
    rating = models.IntegerField(validators=[MinValueValidator(1), MaxValueValidator(5)])
    completed = models.BooleanField(default=False)


class Comment(models.Model):
    video = models.ForeignKey(Video, related_name='video_parent')
    owner = models.ForeignKey('auth.User', related_name='comment_parent')
    text = models.TextField(blank=False, max_length=1000)
    date_added = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ('date_added',)

    def __str__(self):
        return self.video.title


class CommentLike(models.Model):
    user = models.ForeignKey(User)
    comment = models.ForeignKey(Comment, related_name='like_parent')

    class Meta:
        unique_together = ("user", "comment")


class ToDo(models.Model):
    user = models.ForeignKey(User, related_name='todo_parent')
    icon = models.CharField(max_length=255)
    text = models.TextField(blank=False, max_length=1000)
    date_added = models.DateTimeField(auto_now_add=True)
    date_completed = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.user.username + ' - TodDos'


class Quiz(models.Model):
    video = models.ForeignKey(Video, related_name='video')
    title = models.CharField(max_length=255)

    def __str__(self):
        return 'Video:' + self.video.title + ' - Quiz: ' + self.title


class QuizQuestion(models.Model):
    quiz = models.ForeignKey(Quiz, related_name='quiz')
    question_text = models.TextField(blank=False, max_length=1000)
    answer = models.BooleanField(default=False)
    correct_message = models.TextField(blank=False, max_length=1000)
    false_message = models.TextField(blank=False, max_length=1000)

    def __str__(self):
        return 'Question: ' + self.quiz.title + ': ' + self.question_text


class QuizResult(models.Model):
    quiz = models.ForeignKey(Quiz)
    user = models.ForeignKey(User, related_name='quiz_parent')
    percent_correct = models.FloatField(validators=[MinValueValidator(0.0), MaxValueValidator(1.0)])
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return 'Quiz Results for : ' + self.quiz.title


@receiver(post_save, sender=User)
def create_profile_data(sender, **kwargs):
    if kwargs.get('created', False):
        ToDo.objects.create(user=kwargs.get('instance'), icon="mm-Button-trash-icon",
                            text="Share Money Monster 101!", date_added=models.DateTimeField(auto_now_add=True))
