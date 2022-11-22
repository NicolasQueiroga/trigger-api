from django.urls import path, include
from trigger import views

urlpatterns = [
    path('', views.receive_answer, name='post results'),
]
