from django.contrib.auth.models import User
from django.contrib.contenttypes.fields import GenericForeignKey
from django.contrib.contenttypes.fields import GenericRelation
from django.contrib.contenttypes.models import ContentType
from django.core.validators import MinValueValidator, MaxValueValidator
from django.db import models
from django.db.models import Avg
from django.db.models.signals import post_save
from django.dispatch import receiver


# a quiz was "passed" if this percentage of quiz questions was answered correctly
QUIZ_PASS_PERCENTAGE = 0.7


# video data
class Video(models.Model):
    sort_order = models.IntegerField(default=0)
    title = models.CharField(max_length=255)
    description = models.CharField(max_length=255)
    thumbnail_filename = models.CharField(max_length=255)
    todo_text = models.CharField(max_length=255)
    todo_icon = models.CharField(max_length=255)
    hls_url = models.CharField(max_length=255)
    rtmp_server_url = models.CharField(max_length=255)
    rtmp_stream_name = models.CharField(max_length=255)
    comments = GenericRelation('Comment')
    quiz = models.ForeignKey('Quiz', default=None, null=True, blank=True)

    def rating(self):
        objlst = VideoStatus.objects.filter(video=self, rating__isnull=False)
        if objlst.count() == 0:
            return None
        ratavg = objlst.aggregate(Avg('rating')).values()[0]
        ratavg = max(min(ratavg, 5.0), 0.0)  # clamp
        return ratavg

    def __str__(self):
        return 'Video(title:' + self.title + ')'


# video status for a particular user
class VideoStatus(models.Model):
    video = models.ForeignKey(Video)
    user = models.ForeignKey(User)
    rating = models.IntegerField(validators=[MinValueValidator(1), MaxValueValidator(5)],
                                 default=None, null=True, blank=True)
    completed = models.BooleanField(default=False, blank=True)

    class Meta:
        unique_together = ("video", "user")

    def __str__(self):
        return 'VideoStatus(video:' + self.video.title + ', user:' + self.user.username + ')'


# a user comment, which may be attached to other app models (video, quiz, another comment, etc.)
class Comment(models.Model):
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE,
                                     limit_choices_to=models.Q(app_label='MoneyMonsterData'))
    object_id = models.PositiveIntegerField()
    content_object = GenericForeignKey('content_type', 'object_id')
    user = models.ForeignKey(User)
    text = models.TextField(blank=False, max_length=1000)
    date_added = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ('date_added',)

    def __str__(self):
        return 'Comment(user:' + self.user.username + ', text:' + self.text + ')'


# a user "like" on another user's comment
class CommentLike(models.Model):
    user = models.ForeignKey(User)
    comment = models.ForeignKey(Comment)

    class Meta:
        unique_together = ("user", "comment")


# a user To Do item
class ToDo(models.Model):
    user = models.ForeignKey(User)
    icon = models.CharField(max_length=255)
    text = models.TextField(blank=False, max_length=1000)
    date_added = models.DateTimeField(auto_now_add=True)
    completed = models.BooleanField(default=False)
    date_completed = models.DateTimeField(default=None, null=True, blank=True)

    def __str__(self):
        return 'ToDo(user:' + self.user.username + ')'


# a quiz
class Quiz(models.Model):
    title = models.CharField(max_length=255)

    def __str__(self):
        return 'Quiz(title:' + self.title + ')'


# a true/false quiz question, part of a quiz
class QuizQuestion(models.Model):
    quiz = models.ForeignKey(Quiz)
    statement = models.TextField(blank=False, max_length=1000)
    statement_is_true = models.BooleanField(default=False)
    statement_message = models.TextField(blank=True, max_length=1000)

    def __str__(self):
        return 'QuizQuestion(quiz:' + self.quiz.title + ', statement:' + self.statement + ')'


# a user's quiz result
class QuizResult(models.Model):
    quiz = models.ForeignKey(Quiz)
    user = models.ForeignKey(User)
    percent_correct = models.FloatField(validators=[MinValueValidator(0.0), MaxValueValidator(1.0)])
    date = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ("quiz", "user")

    def passed(self):
        return self.percent_correct >= QUIZ_PASS_PERCENTAGE

    def __str__(self):
        return 'QuizResult(quiz:' + self.quiz.title + ', user:' + self.user.username +\
               ', percent_correct:' + str(self.percent_correct) + ')'


# function that runs after a User was created
@receiver(post_save, sender=User)
def create_profile_data(sender, **kwargs):
    if kwargs.get('created', False):
        ToDo.objects.create(user=kwargs.get('instance'), icon="todo-icon-share",
                            text="Share Money Monster 101!", date_added=models.DateTimeField(auto_now_add=True))
