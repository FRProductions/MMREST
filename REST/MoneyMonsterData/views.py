from django.db import IntegrityError
from django.shortcuts import get_object_or_404
from rest_framework import generics
from rest_framework import permissions
from rest_framework.decorators import api_view
from rest_framework.exceptions import ValidationError
from rest_framework.response import Response
from rest_framework.reverse import reverse

from .models import User, Video, VideoStatus, Quiz, QuizQuestion, Comment, CommentLike, ToDo
from .permissions import IsOwnerOrReadOnly, IsOwner
from .serializers import UserSerializer, VideoSummarySerializer, VideoDetailSerializer, VideoStatusSerializer,\
                         QuizSerializer, QuizQuestionSerializer, CommentSerializer, CommentLikeSerializer,\
                         ProfileSerializer, ToDosSerializer


###
# Root
###

@api_view(['GET'])
def api_root(request, format=None):
    return Response({
        'api-version': '0.1.1',
        'quizzes': reverse('quiz-list', request=request, format=format),
        'comments': reverse('comment-list', request=request, format=format),
        'videos': reverse('video-list', request=request, format=format),
    })


###
# User
###

class UserList(generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class UserDetail(generics.RetrieveAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


###
# Videos
###

class VideoList(generics.ListAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    queryset = Video.objects.all().order_by('sort_order', 'id')  # order first by 'sort_order', then by 'id'
    serializer_class = VideoSummarySerializer


class VideoDetail(generics.RetrieveAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    queryset = Video.objects.all()
    serializer_class = VideoDetailSerializer


###
# Video Status
###

class VideoStatusDetail(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (permissions.IsAuthenticated, IsOwner,)
    serializer_class = VideoStatusSerializer

    def get_object(self):
        # get related Video object (video id is in url)
        video = get_object_or_404(Video, pk=self.kwargs['pk'])

        # lookup the VideoStatus object that matches the video and user (should be only 1 if found)
        queryset = VideoStatus.objects.filter(video=video, user=self.request.user)
        if queryset.count() == 1:
            return queryset[0]                                          # return existing VideoStatus object instance
        else:
            return VideoStatus(video=video, user=self.request.user)     # return new VideoStatus object instance


###
# Quiz
###

class QuizList(generics.ListAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    queryset = Quiz.objects.all()
    serializer_class = QuizSerializer


class QuizDetail(generics.RetrieveAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    queryset = Quiz.objects.all()
    serializer_class = QuizSerializer


###
# Comments
###

class CommentList(generics.ListCreateAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class CommentDetail(generics.RetrieveUpdateAPIView):
    permission_classes = (permissions.IsAuthenticated, IsOwnerOrReadOnly,)
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer


class CommentLatestList(generics.ListAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = CommentSerializer

    def get_queryset(self):
        return Comment.objects.all().order_by('-date_added')[:20]


###
# Comments Likes
###

class CommentLikeList(generics.ListCreateAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = CommentLikeSerializer

    def get_queryset(self):
        return CommentLike.objects.filter(user=self.request.user)  # filter for the current user

    def perform_create(self, serializer):
        try:
            serializer.save(user=self.request.user)  # save only for the current user
        except IntegrityError:
            raise ValidationError('current user has already liked this comment')


class CommentLikeDetail(generics.RetrieveDestroyAPIView):
    permission_classes = (permissions.IsAuthenticated, IsOwner,)
    queryset = CommentLike.objects.all()
    serializer_class = CommentLikeSerializer


###
#  Profile
###

class ProfileList(generics.ListAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = ProfileSerializer

    def get_queryset(self):
        return User.objects.filter(id=self.request.user.id)  # filter for the current user


###
# To Do
###

class TodoList(generics.ListCreateAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = ToDosSerializer

    def get_queryset(self):
        return ToDo.objects.filter(user=self.request.user)  # filter for the current user

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)  # save only for the current user


class TodoDetail(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (permissions.IsAuthenticated, IsOwner,)
    queryset = ToDo.objects.all()
    serializer_class = ToDosSerializer

