from django.contrib import admin
from .models import *


# Comments Admin
class CommentLikesInLine(admin.StackedInline):
    model = CommentLikes


class CommentInfoInLine(admin.StackedInline):
    model = CommentInfo


class CommentsInLine(admin.StackedInline):
    model = Comments


class CommentAdmin(admin.ModelAdmin):
    inlines = [CommentInfoInLine]


# Haps Admin
# class HapsAdmin(admin.StackedInline):
#     model = Haps


# Video admin
class VideoStatusInline(admin.StackedInline):
    model = VideoStatus


class VideoAdmin(admin.ModelAdmin):
    inlines = [VideoStatusInline, CommentsInLine]


# Quiz admin
class QuizAnswersInline(admin.StackedInline):
    model = QuizAnswers


class QuizQuestionsInline(admin.StackedInline):
    model = QuizQuestions


class QuizAdmin(admin.ModelAdmin):
    inlines = [QuizQuestionsInline, ]


admin.site.register(Video, VideoAdmin)
admin.site.register(Comments,  CommentAdmin)
admin.site.register(Quizzes, QuizAdmin)
admin.site.register(QuizAnswers)
admin.site.register(Profile)
