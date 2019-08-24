from django.shortcuts import render
from rest_framework import viewsets
from .models import Donor
from .serializers import DonorSerializer

# Create your views here.
class DonorView(viewsets.ModelViewSet):
    queryset = Donor.objects.all()
    serializer_class = DonorSerializer
