from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Donor(models.Model):
    user = models.OneToOneField(User,
                                on_delete=models.CASCADE,
                                related_name='Donor',
                                null=True)
    customerId = models.CharField(max_length=50)
    uid = models.CharField(max_length=30,null=True)
    total_reimbursements_made = models.IntegerField(default=0)
    total_reimbursements_value = models.DecimalField(default=0.0, max_digits=20, decimal_places=2)

    def __str__(self):
        return self.user.username

class Recipient(models.Model):
    user = models.OneToOneField(User,
                                on_delete=models.CASCADE,
                                related_name='Recipient',
                                null=True)
    location = models.CharField(max_length=30)
    uid = models.CharField(max_length=30,null=True)
    yearly_income = models.DecimalField(default=0.0, max_digits=20, decimal_places=2)
    total_reimbursements_accepted = models.IntegerField(default=0)
    total_reimbursements_value = models.DecimalField(default=0.0, max_digits=20, decimal_places=2)

    def __str__(self):
        return self.user.username

class Store(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length = 50)
    location = models.CharField(max_length = 200)
    total_purchases_value = models.DecimalField(default=0.0, max_digits=20, decimal_places=2)
    total_reimbursements_value = models.DecimalField(default=0.0, max_digits=20, decimal_places=2)

    def __str__(self):
        return self.user.username

class Purchase(models.Model):
    id = models.AutoField(primary_key=True)
    recipient = models.ForeignKey(Recipient,
                            on_delete=models.SET_NULL,
                            null=True)
    donor = models.ForeignKey(Donor,
                            on_delete=models.SET_NULL,
                            null=True)
    store = models.ForeignKey(Store,
                            on_delete=models.SET_NULL,
                            null=True)
    purchase_value = models.DecimalField(default=0.0, max_digits=20, decimal_places=2)

    def __str__(self):
        return str(self.id)
