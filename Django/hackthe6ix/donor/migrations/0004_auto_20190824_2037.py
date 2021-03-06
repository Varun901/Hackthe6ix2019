# Generated by Django 2.1.11 on 2019-08-25 00:37

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('donor', '0003_recipient_location'),
    ]

    operations = [
        migrations.AddField(
            model_name='donor',
            name='uid',
            field=models.CharField(max_length=30, null=True),
        ),
        migrations.AddField(
            model_name='recipient',
            name='uid',
            field=models.CharField(max_length=30, null=True),
        ),
        migrations.AlterField(
            model_name='donor',
            name='user',
            field=models.OneToOneField(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='Donor', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='recipient',
            name='user',
            field=models.OneToOneField(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='Recipient', to=settings.AUTH_USER_MODEL),
        ),
    ]
