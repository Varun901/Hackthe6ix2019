from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Donor(models.Model):
    user = models.OneToOneField(User,
                                on_delete=models.CASCADE,
                                primary_key=True,
                                related_name='User')
    customerId = models.CharField(max_length=50)