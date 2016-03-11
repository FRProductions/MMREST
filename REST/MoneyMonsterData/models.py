from django.db import models
from django.contrib.auth.models import User


class UserProfile(models.Model):
    created = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.usename + "'s profile"

profile = User(username='Ryan', email='ryan@gmail.com')
