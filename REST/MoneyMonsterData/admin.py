from django.contrib import admin
from .models import *


# Comments Admin
# class CommentLikesInLine(admin.StackedInline):
#     model = CommentLikes


class CommentInfoInLine(admin.StackedInline):
    model = CommentInfo


class CommentAdmin(admin.ModelAdmin):
    inlines = [CommentInfoInLine]


class CommentsInLine(admin.StackedInline):
    model = Comments


# Video admin
class VideoStatusInline(admin.StackedInline):
    model = VideoStatus


class VideoAdmin(admin.ModelAdmin):
    inlines = [VideoStatusInline, CommentsInLine]


class QuizInline(admin.StackedInline):
    model = QuizResults


class QuizQuestionsInline(admin.StackedInline):
    model = QuizQuestions


class QuizAdmin(admin.ModelAdmin):
    inlines = [QuizQuestionsInline, QuizInline]


class ToDoInLine(admin.StackedInline):
    model = ToDos


class ProfileInLine(admin.StackedInline):
    model = Profile


class ProfileAdmin(admin.ModelAdmin):
    inlines = [ProfileInLine, ToDoInLine]


admin.site.register(Video, VideoAdmin)
admin.site.register(Comments,  CommentAdmin)
admin.site.register(Quizzes, QuizAdmin)
admin.site.register(Profile)
admin.site.register(ToDos)
