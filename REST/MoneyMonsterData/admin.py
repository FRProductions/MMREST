from django.contrib import admin
from .models import *


class CommentLikeInLine(admin.StackedInline):
    model = CommentLike


class CommentInLine(admin.StackedInline):
    model = Comment


class CommentAdmin(admin.ModelAdmin):
    inlines = [CommentLikeInLine]


class VideoStatusInline(admin.StackedInline):
    model = VideoStatus


# Video admin
class VideoAdmin(admin.ModelAdmin):
    inlines = [VideoStatusInline, CommentInLine]


class QuizInline(admin.StackedInline):
    model = QuizResults


class QuizQuestionsInline(admin.StackedInline):
    model = QuizQuestions


class QuizAdmin(admin.ModelAdmin):
    inlines = [QuizQuestionsInline, QuizInline]


class ToDoInLine(admin.StackedInline):
    model = ToDo


class ProfileInLine(admin.StackedInline):
    model = Profile


class ProfileAdmin(admin.ModelAdmin):
    inlines = [ProfileInLine, ToDoInLine]


admin.site.register(Video, VideoAdmin)
admin.site.register(Comment, CommentAdmin)
admin.site.register(Quizzes, QuizAdmin)
admin.site.register(Profile)
admin.site.register(ToDo)
