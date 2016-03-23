from .models import Video, Quizzes, QuizQuestions
from .serializers import QuizQuestionSerializer, UserSerializer, VideoSerializer, QuizSerializer
from django.contrib.auth.models import User
from rest_framework import generics
from rest_framework.response import Response
from rest_framework.reverse import reverse
from rest_framework.decorators import api_view


@api_view(['GET'])
def api_root(request, format=None):
    return Response({
        'users': reverse('user-list', request=request, format=format),
        'videos': reverse('video-list', request=request, format=format),
    })


# User
class UserList(generics.ListCreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class UserDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


# Video
class VideoList(generics.ListCreateAPIView):
    queryset = Video.objects.all()
    serializer_class = VideoSerializer


class VideoDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Video.objects.all()
    serializer_class = VideoSerializer


# quiz
class QuizList(generics.ListCreateAPIView):
    queryset = Quizzes.objects.all()
    serializer_class = QuizSerializer


class QuizDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Quizzes.objects.all()
    serializer_class = QuizSerializer


# questions
class QuizQuestionsList(generics.ListCreateAPIView):
    queryset = QuizQuestions.objects.all()
    serializer_class = QuizQuestionSerializer


class QuizQuestionsDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = QuizQuestions.objects.all()
    serializer_class = QuizQuestionSerializer


