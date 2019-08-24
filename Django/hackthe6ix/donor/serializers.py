from rest_framework import serializers
from .models import *

class DonorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Donor
        fields = ('user', 'customerId','total_reimbursements_made','total_reimbursements_value')

class RecipientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Recipient
        fields = ('user', 'yearly_income','total_reimbursements_accepted','total_reimbursements_value')

class StoreSerializer(serializers.ModelSerializer):
    class Meta:
        model = Store
        fields = ('id', 'name','location','total_purchases_value','total_reimbursements_value')

class PurchaseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Purchase
        fields = ('id', 'recipient', 'donor', 'store', 'purchase_value')

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('username', 'email', 'id')