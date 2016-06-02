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
    queryset = Quizzes.objects.all()
    serializer_class = QuizSerializer


class QuizDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Quizzes.objects.all()
    serializer_class = QuizSerializer


###
# Quiz Questions
###

class QuizQuestionsList(generics.ListCreateAPIView):
    queryset = QuizQuestions.objects.all()
    serializer_class = QuizQuestionSerializer


class QuizQuestionsDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = QuizQuestions.objects.all()
    serializer_class = QuizQuestionSerializer


###
# Comments
###

class CommentList(generics.ListCreateAPIView):
    queryset = Comments.objects.all()
    serializer_class = CommentSerializer


class CommentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Comments.objects.all()
    serializer_class = CommentSerializer


###
# Comment Info
###

class CommentInfoList(generics.ListCreateAPIView):
    queryset = CommentInfo.objects.all()
    serializer_class = CommentInfoSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)


class CommentInfoDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = CommentInfo.objects.all()
    serializer_class = CommentInfoSerializer


###
#  Haps/Profile
###

class ProfileList(generics.ListCreateAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer

    def get_queryset(self):
        """
        This view should return a list of profile data
        for the currently authenticated user.
        """
        user = self.request.user
        return Profile.objects.filter(user_id=user)


class ProfileDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer


###
# To Do
###

class TodosList(generics.ListCreateAPIView):
    queryset = ToDos.objects.all()
    serializer_class = ToDosSerializer

    def get_queryset(self):
        """
        This view should return todo
        for the currently authenticated user.
        """
        user = self.request.user
        return ToDos.objects.filter(user_id=user)


class TodosDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = ToDos.objects.all()
    serializer_class = ToDosSerializer


###
# Quiz Results
###

class QuizResultsList(generics.ListCreateAPIView):
    queryset = QuizResults.objects.all()
    serializer_class = QuizResultsSerializer

    def get_queryset(self):
        """
        This view should return a list of profile data
        for the currently authenticated user.
        """
        user = self.request.user
        return QuizResults.objects.filter(user_id=user)


class QuizResultsDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = QuizResults.objects.all()
    serializer_class = QuizResultsSerializer
