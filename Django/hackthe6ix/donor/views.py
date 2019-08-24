from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.views import APIView
from .models import *
from .serializers import *

# Create your views here.

class DonorRegistration(APIView):
    def post(self, request, format=None):
        data = request.DATA
        username = data.get('username', None)
        password = data.get('password', None)
        email = data.get('email', None)
        first_name = data.get('first name', None)
        last_name = data.get('last name', None)
        if (username != None) or (password != None):
            new_user = User(username=username, password=password, email=email, first_name = first_name, last_name = last_name)
            new_user.save()
            new_donor = Donor(user=User.objects.get(username=username))
            new_donor.save()  


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


    # Donor Registration 
    # Donor Login
    # Donor Profile
    # Recipient Search

    # Recipient Registration
    # Recipient Login
    # Recipient Profile
    
    # Store Registration
    # Store Login
    # Store Profile