from allauth.socialaccount.providers.facebook.views import FacebookOAuth2Adapter
from rest_auth.registration.views import SocialLoginView


# workaround according to https://github.com/Tivix/django-rest-auth/issues/195
class FacebookOAuth2AdapterFixed(FacebookOAuth2Adapter):
    def __init__(self):
        pass


class FacebookLogin(SocialLoginView):
    adapter_class = FacebookOAuth2AdapterFixed
