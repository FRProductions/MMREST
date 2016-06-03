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
    video_id = models.ForeignKey(Video)
    user_id = models.ForeignKey(User)
    rating = models.IntegerField(validators=[MinValueValidator(1), MaxValueValidator(5)])
    eye_status = models.BooleanField(default=False)
    check_status = models.BooleanField(default=False)


class Comments(models.Model):
    parent_id = models.ForeignKey(Video, related_name='video_parent')

    def __str__(self):
        return self.parent_id.title


class CommentInfo(models.Model):
    comment_id = models.ForeignKey(Comments, related_name='comment_parent')
    owner = models.ForeignKey('auth.User')
    text = models.TextField(blank=False, max_length=1000)
    date_added = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ('date_added',)


class CommentLikes(models.Model):
    user_id = models.ForeignKey(User)
    comment_id = models.ForeignKey(Comments)
    liked = models.BooleanField(default=False)


class ToDos(models.Model):
    user_id = models.ForeignKey(User, related_name='todo_parent')
    icon_id = models.CharField(max_length=255)
    text = models.TextField(blank=False, max_length=1000)
    date_added = models.DateTimeField(auto_now_add=True)
    date_completed = models.DateTimeField(auto_now_add=True)


class Quizzes(models.Model):
    video_id = models.ForeignKey(Video, related_name='video')
    title = models.CharField(max_length=255)

    def __str__(self):
        return 'Video:' + self.video_id.title + ' - Quiz: ' + self.title


class QuizQuestions(models.Model):
    quiz_id = models.ForeignKey(Quizzes, related_name='quiz')
    question_text = models.TextField(blank=False, max_length=1000)
    answer = models.BooleanField(default=False)
    correct_answer = models.TextField(blank=False, max_length=1000)
    false_answer = models.TextField(blank=False, max_length=1000)

    def __str__(self):
        return 'Question: ' + self.quiz_id.title + ': ' + self.question_text


class QuizResults(models.Model):
    quiz_id = models.ForeignKey(Quizzes)
    user_id = models.ForeignKey(User, related_name='quiz_parent')
    passed = models.BooleanField(default=False)
    score = models.IntegerField(validators=[MinValueValidator(0), MaxValueValidator(100)])
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return 'Quiz Results for : ' + self.quiz_id.title


class Profile(models.Model):
    user_id = models.OneToOneField(User, related_name='User')
    passed = models.IntegerField(validators=[MinValueValidator(0), MaxValueValidator(100)], default=0)
    failed = models.IntegerField(validators=[MinValueValidator(0), MaxValueValidator(100)], default=0)
    tasks = models.IntegerField(validators=[MinValueValidator(0), MaxValueValidator(1000)], default=0)
    discussions = models.IntegerField(validators=[MinValueValidator(0), MaxValueValidator(1000)], default=0)

    def __str__(self):
        return self.user_id.username + ' haps'


@receiver(post_save, sender=User)
def create_profile_data(sender, **kwargs):
    if kwargs.get('created', False):
        Profile.objects.create(user_id=kwargs.get('instance'), passed=0, failed=0, tasks=0, discussions=0)
