from django.urls import path, include
from . import views
from rest_framework import routers

router = routers.DefaultRouter()
router.register('donors', views.DonorView)
router.register('users', views.UserView)
router.register('recipients', views.RecipientView)
router.register('stores', views.StoreView)
router.register('purchases', views.PurchaseView)

urlpatterns = [
    path("", include(router.urls)),
    path('donor/reimburse', views.Reimburse.as_view())
]

# urlpatterns = format_suffix_patterns(urlpatterns)