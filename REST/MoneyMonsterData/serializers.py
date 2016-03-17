from rest_framework import serializers
from django.contrib.auth.models import User
from .models import *


class VideoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Video
        fields = ('title', 'ios', 'android')


