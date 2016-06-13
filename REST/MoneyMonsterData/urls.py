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
        views.TodoList.as_view(),
        name='todo-list'),
    url(r'^user/todo/(?P<pk>[0-9]+)/$',
        views.TodoDetail.as_view(),
        name='todo-detail'),

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
        name='quiz-list'),
    url(r'^video/(?P<pk>[0-9]+)/quiz/$',
        views.QuizDetail.as_view(),
        name='quiz-detail'),

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
        name='quizresult-list'),
    url(r'^video/(?P<pk>[0-9]+)/quiz/results/detail',
        views.QuizResultsDetail.as_view(),
        name='quizresult-detail'),


    ###
    # Comment urls
    ###

    url(r'^comment/$',
        views.CommentList.as_view(),
        name='comment-list'),
    url(r'^comment/(?P<pk>[0-9]+)/$',
        views.CommentDetail.as_view(),
        name='comment-detail'),


    ###
    # Comment Like urls
    ###

    url(r'^video/comment/like/list/$',
        views.CommentLikeList.as_view(),
        name='commentlike-list'),
    url(r'^video/(?P<pk>[0-9]+)/comment/like/detail/$',
        views.CommentLikeDetail.as_view(),
        name='commentlike-detail'),

])

# Login and logout views for the browsable API
urlpatterns += [
    url(r'^api-auth/', include('rest_framework.urls',
                               namespace='rest_framework')),
]


