from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework import viewsets, status
from rest_framework.response import Response
from .models import *
from django.contrib.auth import *
from .serializers import *
import json

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


class DonorLogin(APIView):
    def post(self, request, format=None):
        data = request.data
        uid = data.get('uid')
        donor = Donor.objects.filter(uid=uid).first()
        if donor is None:
            user = User(username=uid,password="na",email="na")
            user.save()
            donor = Donor(uid=uid,user=user)
            donor.save()
            return Response(
            {
            "success": False,
            "user": { "id":donor.id }
            }
            ,200)
        else:
            user = User.objects.get(id=donor.user.id)
            login(request,user)
            return Response(
            {
            "success": True,
            "user": { "id":donor.id }
            }
            ,200)

class RecipientLogin(APIView):
    def post(self, request, format=None):
        data = request.data
        uid = data.get('uid')
        recipient = Recipient.objects.filter(uid=uid).first()
        if recipient is None:
            user = User(username=uid,password="na",email="na")
            user.save()
            recipient = Recipient(uid=uid,user=user)
            recipient.save()
            return Response(
            {
            "success": False,
            "user": { "id":recipient.id }
            }
            ,200)
        else:
            user = User.objects.get(id=recipient.user.id)
            login(request,user)
            return Response(
            {
            "success": True,
            "user": { "id":recipient.id }
            }
            ,200)
        
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

class UserView(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

# class GetPurchases(APIView):
#     def get(self, request):
#             location = request.query_params.location
#             purchases = Purchase.objects.all()
#             purchases.sort(key=distance)
#             return purchases
#         def distance(point):
#             return Math.sqrt(distance[0]**2 - distance[1]**2)

class Reimburse(APIView):
    def post(self, request, format=None):
        #todo implementing actually charging a credit card
        user = User.objects.get(username=request.user.username)
        purchaseId = request.data.get('purchaseId', None)
        Pur = Purchase.objects.get(id=purchaseId)
        Don = Donor.objects.get(user=request.user)
        Don.total_reimbursements_made += 1
        Don.total_reimbursements_value += Pur.purchase_value
        Don.save()
        Rec = Recipient.objects.get(user=Pur.recipient)
        Rec.total_reimbursements_value += Pur.purchase_value
        Rec.total_reimbursements_accepted += 1
        Rec.save()
        Pur.doner = Don
        print (request.user)
        # Pur.donor = request.user
        Pur.save()
        return Response({"result":"success"},status=status.HTTP_200_OK)

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
