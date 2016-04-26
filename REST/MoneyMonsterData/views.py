from .models import Video, Quizzes, QuizQuestions, Comments, CommentInfo, Haps
from .serializers import QuizQuestionSerializer, UserSerializer, VideoSerializer, VideoDataSerializer, QuizSerializer,\
                         CommentSerializer, CommentInfoSerializer, HapsSerializer
from django.contrib.auth.models import User
from rest_framework import generics
from rest_framework.response import Response
from rest_framework.reverse import reverse
from rest_framework.decorators import api_view
from rest_framework import permissions
from rest_framework.views import APIView
from rest_framework import viewsets


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
    serializer_class = VideoDataSerializer


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


# comment
class CommentList(generics.ListCreateAPIView):
    queryset = Comments.objects.all()
    serializer_class = CommentSerializer


class CommentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Comments.objects.all()
    serializer_class = CommentSerializer


# comment info
class CommentInfoList(generics.ListCreateAPIView):
    queryset = CommentInfo.objects.all()
    serializer_class = CommentInfoSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)


class CommentInfoDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = CommentInfo.objects.all()
    serializer_class = CommentInfoSerializer


# haps
class HapsList(generics.ListCreateAPIView):
    queryset = Haps.objects.all()
    serializer_class = HapsSerializer

    def get_queryset(self):
        """
        This view should return a list of all the purchases
        for the currently authenticated user.
        """
        user = self.request.user
        return Haps.objects.filter(user_id=user)


class HapsDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Haps.objects.all()
    serializer_class = HapsSerializer

