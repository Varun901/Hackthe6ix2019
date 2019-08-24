from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Donor(models.Model):
    user = models.OneToOneField(User,
                                on_delete=models.CASCADE,
                                primary_key=True,
                                related_name='Donor')
    customerId = models.CharField(max_length=50)

class Recipient(models.Model):
    user = models.OneToOneField(User,
                                on_delete=models.CASCADE,
                                primary_key=True,
                                related_name='Recipient')

class Store(models.Model):
    id = models.AutoField(primary_key=True)

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


