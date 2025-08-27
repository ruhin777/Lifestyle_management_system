from django.db import models

class Habit(models.Model):
    name = models.CharField(max_length=100)
    frequency = models.CharField(max_length=50)

    def __str__(self):
        return self.name

# Create your models here.
