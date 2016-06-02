from django.conf.urls import include, url
from django.contrib import admin
from django.views.generic import TemplateView

from .views import FacebookLogin

urlpatterns = [
    url(r'^', include('MoneyMonsterData.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^rest-auth/', include('rest_auth.urls')),
    url(r'^rest-auth/registration/account-confirm-email/(?P<key>\w+)/$',
        TemplateView.as_view(template_name="email_verification.html"),
        name='email-verification'),
    # this one doesn't seem to do anything but needs to be present
    url(r'^rest-auth/registration/account-email-verification-sent/$', TemplateView.as_view(),
        name='account_email_verification_sent'),

    # this url is used to generate email content
    url(r'^password-reset/confirm/(?P<uidb64>[0-9A-Za-z_\-]+)/(?P<token>[0-9A-Za-z]{1,13}-[0-9A-Za-z]{1,20})/$',
        TemplateView.as_view(template_name="password_reset_confirm.html"),
        name='password_reset_confirm'),

    url(r'^rest-auth/registration/', include('rest_auth.registration.urls')),
    url(r'^rest-auth/facebook/$', FacebookLogin.as_view(), name='fb_login'),
]
