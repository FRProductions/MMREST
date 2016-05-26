from django.conf.urls import include, url
from django.contrib import admin

from .views import FacebookLogin

urlpatterns = [
    url(r'^', include('MoneyMonsterData.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^rest-auth/', include('rest_auth.urls')),
    url(r'^rest-auth/registration/', include('rest_auth.registration.urls')),
    url(r'^rest-auth/facebook/$', FacebookLogin.as_view(), name='fb_login'),
]
