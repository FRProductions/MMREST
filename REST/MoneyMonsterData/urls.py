from django.conf.urls import url, include
from MoneyMonsterData import views
from rest_framework.urlpatterns import format_suffix_patterns


# API endpoints
urlpatterns = format_suffix_patterns([
    url(r'^$', views.api_root),
    url(r'^user/$',
        views.UserList.as_view(),
        name='user-list'),
    url(r'^user/(?P<pk>[0-9]+)/$',
        views.UserDetail.as_view(),
        name='user-detail'),
    url(r'^video/$',
        views.VideoList.as_view(),
        name='video-list'),
    url(r'^video/(?P<pk>[0-9]+)/$',
        views.QuizList.as_view(),
        name='video-detail'),
    url(r'^video/(?P<pk>[0-9]+)/quiz/$',
        views.QuizQuestions.as_view(),
        name='quizzes-detail'),
    url(r'^video/(?P<pk>[0-9]+)/quiz/$',
        views.QuizQuestions.as_view(),
        name='quizquestions-detail'),
    #     views.UserList.as_view(),
    #     name='user-list'),
    # url(r'^users/(?P<pk>[0-9]+)/$',
    #     views.UserDetail.as_view(),
    #     name='user-detail')
])

# Login and logout views for the browsable API
urlpatterns += [
    url(r'^api-auth/', include('rest_framework.urls',
                               namespace='rest_framework')),
]
