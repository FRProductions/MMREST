from .models import *
from .serializers import *
from rest_framework import generics
from rest_framework import renderers
from rest_framework.response import Response


class VideoList(generics.ListCreateAPIView):
    queryset = Video.objects.all()
    serializer_class = VideoSerializer


class VideoDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Video.objects.all()
    serializer_class = VideoSerializer