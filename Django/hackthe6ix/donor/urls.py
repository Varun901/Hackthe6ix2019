from django.urls import path, include
from . import views
from rest_framework import routers

router = routers.DefaultRouter()
router.register('donors', views.DonorView)

urlpatterns = [
    path("", include(router.urls))
]