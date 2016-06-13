from django.contrib import admin
from django.contrib.contenttypes import admin as ct_admin
from .models import *


class CommentLikeInLine(admin.StackedInline):
    model = CommentLike


class CommentInLine(ct_admin.GenericTabularInline):
    model = Comment


class CommentAdmin(admin.ModelAdmin):
    inlines = [CommentLikeInLine]


class VideoStatusInline(admin.StackedInline):
    model = VideoStatus


class VideoAdmin(admin.ModelAdmin):
    inlines = [VideoStatusInline, CommentInLine]


class QuizInline(admin.StackedInline):
    model = QuizResult


class QuizQuestionsInline(admin.StackedInline):
    model = QuizQuestion


class QuizAdmin(admin.ModelAdmin):
    inlines = [QuizQuestionsInline, QuizInline]


class ToDoInLine(admin.StackedInline):
    model = ToDo


admin.site.register(Video, VideoAdmin)
admin.site.register(Comment, CommentAdmin)
admin.site.register(Quiz, QuizAdmin)
admin.site.register(ToDo)
