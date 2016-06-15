from .models import *
from .serializers import *
from django.contrib.auth.models import User
from rest_framework import generics
from rest_framework.response import Response
from rest_framework.reverse import reverse
from rest_framework.decorators import api_view
from rest_framework import permissions


@api_view(['GET'])
def api_root(request, format=None):
    return Response({
        'users': reverse('user-list', request=request, format=format),
        'videos': reverse('video-list', request=request, format=format),
    })

###
# User
###


class UserList(generics.ListCreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class UserDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


###
# Videos
###

class VideoList(generics.ListCreateAPIView):
    queryset = Video.objects.all()
    serializer_class = VideoSerializer


class VideoDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Video.objects.all()
    serializer_class = VideoDataSerializer


###
# Quiz
###

class QuizList(generics.ListCreateAPIView):
    queryset = Quiz.objects.all()
    serializer_class = QuizSerializer


class QuizDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Quiz.objects.all()
    serializer_class = QuizSerializer


###
# Quiz Questions
###

class QuizQuestionsList(generics.ListCreateAPIView):
    queryset = QuizQuestion.objects.all()
    serializer_class = QuizQuestionSerializer


class QuizQuestionsDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = QuizQuestion.objects.all()
    serializer_class = QuizQuestionSerializer


###
# Comments
###

class CommentList(generics.ListCreateAPIView):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer


class CommentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer


###
# Comments Likes
###

class CommentLikeList(generics.ListCreateAPIView):
    queryset = CommentLike.objects.all()
    serializer_class = CommentSerializer


class CommentLikeDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = CommentLike.objects.all()
    serializer_class = CommentSerializer


###
#  Profile
###

class ProfileList(generics.ListCreateAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    queryset = User.objects.all()
    serializer_class = ProfileSerializer

    def get_queryset(self):
        """
        This view should return a list of profile data
        for the currently authenticated user.
        """
        user = self.request.user
        return User.objects.filter(user_id=user)


class ProfileDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    serializer_class = ProfileSerializer


###
# To Do
###


class TodoList(generics.ListCreateAPIView):
    queryset = ToDo.objects.all()
    serializer_class = ToDosSerializer

    def get_queryset(self):
        """
        This view should return todo
        for the currently authenticated user.
        """
        user = self.request.user
        return ToDo.objects.filter(user_id=user)


class TodoDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = ToDo.objects.all()
    serializer_class = ToDosSerializer


###
# Quiz Results
###

class QuizResultsList(generics.ListCreateAPIView):
    queryset = QuizResult.objects.all()
    serializer_class = QuizResultsSerializer

    def get_queryset(self):
        """
        This view should return a list of profile data
        for the currently authenticated user.
        """
        user = self.request.user
        return QuizResult.objects.filter(user_id=user)


class QuizResultsDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = QuizResult.objects.all()
    serializer_class = QuizResultsSerializer
