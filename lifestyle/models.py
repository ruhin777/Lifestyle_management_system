from django.db import models

class User(models.Model):
    user_id = models.CharField(primary_key=True, max_length=100)
    name = models.CharField(max_length=100)
    password = models.CharField(unique=True, max_length=100)
    age = models.IntegerField()
    gender = models.CharField(max_length=10)
    height = models.DecimalField(max_digits=4, decimal_places=3)
    weight = models.DecimalField(max_digits=6, decimal_places=3)
    activity_level = models.IntegerField()
    activity_multiplier = models.DecimalField(max_digits=4, decimal_places=3)

    class Meta:
        managed = False
        db_table = 'user'


class Dietplan(models.Model):
    diet_plan_id = models.CharField(primary_key=True, max_length=100)
    date = models.DateField()
    meal = models.CharField(max_length=10)
    total_calories = models.FloatField()
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'dietplan'


class Exercise(models.Model):
    exercise_id = models.CharField(primary_key=True, max_length=100)
    exercise_name = models.CharField(max_length=100)
    type = models.CharField(max_length=100)
    calories_burned_per_hour = models.FloatField()
    benefits = models.CharField(max_length=200)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'exercise'


class HealthProblem(models.Model):
    health_id = models.CharField(primary_key=True, max_length=100)
    problem_name = models.CharField(max_length=100)
    description = models.CharField(max_length=300)

    class Meta:
        managed = False
        db_table = 'health_problem'


class ExerciseRestriction(models.Model):
    exercise_restriction_id = models.CharField(primary_key=True, max_length=100)
    e_reason = models.CharField(max_length=100)
    e_severity = models.CharField(max_length=30)
    health = models.ForeignKey(HealthProblem, on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'exercise_restriction'


class FoodNutrition(models.Model):
    food_id = models.CharField(primary_key=True, max_length=100)
    food_name = models.CharField(max_length=100)
    calories_100g = models.FloatField()
    protein_100g = models.FloatField()
    fat_100g = models.FloatField()
    carbs_100g = models.FloatField()
    health_benefits = models.CharField(max_length=200)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'food_nutrition'


class FoodRestriction(models.Model):
    food_restriction_id = models.CharField(primary_key=True, max_length=100)
    f_reason = models.CharField(max_length=100)
    f_severity = models.CharField(max_length=30)
    health = models.ForeignKey(HealthProblem, on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'food_restriction'


class Affects(models.Model):
    food_restriction = models.ForeignKey(FoodRestriction, on_delete=models.CASCADE)
    food = models.ForeignKey(FoodNutrition, on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'affects'
        unique_together = (('food_restriction', 'food'),)


class AppliesTo(models.Model):
    exercise_restriction = models.ForeignKey(ExerciseRestriction, on_delete=models.CASCADE)
    exercise = models.ForeignKey(Exercise, on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'applies_to'
        unique_together = (('exercise_restriction', 'exercise'),)


class Includes(models.Model):
    diet_plan = models.ForeignKey(Dietplan, on_delete=models.CASCADE)
    food = models.ForeignKey(FoodNutrition, on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'includes'
        unique_together = (('diet_plan', 'food'),)


class SuffersFrom(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    health = models.ForeignKey(HealthProblem, on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'suffers_from'
        unique_together = (('user', 'health'),)


# Create your models here.
