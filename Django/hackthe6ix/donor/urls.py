from django.urls import path, include
from . import views
from rest_framework import routers

router = routers.DefaultRouter()
router.register('donors', views.DonorView)
router.register('recipients', views.RecipientView)
router.register('stores', views.StoreView)
router.register('purchases', views.PurchaseView)

urlpatterns = [
    path("", include(router.urls))
]