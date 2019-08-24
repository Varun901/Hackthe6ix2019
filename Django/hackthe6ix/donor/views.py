from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework import viewsets
from rest_framework.response import Response
from .models import *
from .serializers import *

# Create your views here.
class DonorView(viewsets.ModelViewSet):
    queryset = Donor.objects.all()
    serializer_class = DonorSerializer

class RecipientView(viewsets.ModelViewSet):
    queryset = Recipient.objects.all()
    serializer_class = RecipientSerializer

class StoreView(viewsets.ModelViewSet):
    queryset = Store.objects.all()
    serializer_class = StoreSerializer

class PurchaseView(viewsets.ModelViewSet):
    queryset = Purchase.objects.all()
    serializer_class = PurchaseSerializer

class GetPurchases(APIView):
    def get(self, request):
            location = request.query_params.location
            purchases = Purchase.objects.all()
            purchases.sort(key=distance)
            return purchases
        def distance(point):
            return Math.sqrt(distance[0]**2 - distance[1]**2)

class Reimburse(APIView):
    def post(self, request):
        #todo implementing actually charging a credit card
        purchaseId = request.data.purchaseId
        Purchase.objects.get(id=purchaseId)
        Purchase.donor = request.user
        Purchase.save()
        return Response({result:success},status=HTTP_200_OK)
