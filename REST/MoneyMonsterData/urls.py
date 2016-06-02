from django.conf.urls import url, include
from MoneyMonsterData import views
from rest_framework.urlpatterns import format_suffix_patterns


# API endpoints
urlpatterns = format_suffix_patterns([
    url(r'^$', views.api_root),

    ###
    # User urls
    ###

    url(r'^user/$',
        views.UserList.as_view(),
        name='user-list'),
    url(r'^user/(?P<pk>[0-9]+)/$',
        views.UserDetail.as_view(),
        name='user-detail'),


    ###
    # Profile urls
    ###

    url(r'^user/profile/$',
        views.ProfileList.as_view(),
        name='profile-list'),
    url(r'^user/profile/(?P<pk>[0-9]+)/$',
        views.ProfileDetail.as_view(),
        name='profile-detail'),

    ###
    # ToDos urls
    ###

    url(r'^user/todo/$',
        views.TodosList.as_view(),
        name='todos-list'),
    url(r'^user/todo/(?P<pk>[0-9]+)/$',
        views.TodosDetail.as_view(),
        name='todos-detail'),

    ###
    # Video urls
    ###

    url(r'^video/$',
        views.VideoList.as_view(),
        name='video-list'),
    url(r'^video/(?P<pk>[0-9]+)/$',
        views.VideoDetail.as_view(),
        name='video-detail'),

    ###
    # Quiz urls
    ###

    url(r'^video/(?P<pk>[0-9]+)/quiz/list/$',
        views.QuizList.as_view(),
        name='quizzes-list'),
    url(r'^video/(?P<pk>[0-9]+)/quiz/$',
        views.QuizDetail.as_view(),
        name='quizzes-detail'),

    ###
    # Questions urls
    ###

    url(r'^video/(?P<pk>[0-9]+)/quiz/questions/list',
        views.QuizQuestionsList.as_view(),
        name='quizquestions-list'),
    url(r'^video/(?P<pk>[0-9]+)/quiz/questions/detail',
        views.QuizQuestionsDetail.as_view(),
        name='quizquestions-detail'),

     ###
    # Quiz results urls
    ###

    url(r'^video/(?P<pk>[0-9]+)/quiz/results/list',
        views.QuizResultsList.as_view(),
        name='quizresults-list'),
    url(r'^video/(?P<pk>[0-9]+)/quiz/results/detail',
        views.QuizResultsDetail.as_view(),
        name='quizresults-detail'),


    ###
    # Comment urls
    ###

    url(r'^video/(?P<pk>[0-9]+)/comments/list/$',
        views.CommentList.as_view(),
        name='comments-list'),
    url(r'^video/(?P<pk>[0-9]+)/comments/detail/$',
        views.CommentDetail.as_view(),
        name='comments-detail'),

     ###
    # Comment Info urls
    ###

    url(r'^video/(?P<pk>[0-9]+)/comments/info/list/$',
        views.CommentInfoList.as_view(),
        name='commentinfo-list'),
    url(r'^video/(?P<pk>[0-9]+)/comments/info/detail/$',
        views.CommentInfoDetail.as_view(),
        name='commentinfo-detail'),
])

# Login and logout views for the browsable API
urlpatterns += [
    url(r'^api-auth/', include('rest_framework.urls',
                               namespace='rest_framework')),
]


