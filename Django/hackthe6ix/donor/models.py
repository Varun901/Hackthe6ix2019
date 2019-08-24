from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class User_(models.Model):
    user = models.OneToOneField(User,
                                on_delete=models.CASCADE,
                                primary_key=True,
                                related_name='user')
    

class Donor(models.Model):
    user = models.OneToOneField(User_,
                                on_delete=models.CASCADE,
                                primary_key=True,
                                related_name='user')
    customerId = models.CharField()