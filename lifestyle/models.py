from django.db import models
import re
from django.db.models import Max   # ✅ add this


class User(models.Model):
    user_id = models.CharField(primary_key=True, max_length=100)
    name = models.CharField(max_length=100)
    password = models.CharField(unique=True, max_length=100)  # unique enforced
    age = models.IntegerField()
    gender = models.CharField(max_length=10)
    height = models.DecimalField(max_digits=4, decimal_places=3)  # meters
    weight = models.DecimalField(max_digits=6, decimal_places=3)  # kg

    activity_level = models.IntegerField(
        choices=[
            (1, "Level 1 - Little or no exercise"),
            (2, "Level 2 - Exercise 1–3 times per week"),
            (3, "Level 3 - Exercise 3–5 times per week"),
            (4, "Level 4 - Exercise 6–7 times per week"),
            (5, "Level 5 - Very active (hard exercise & physical job)"),
        ],
        default=1
    )
    daily_calories = models.FloatField(blank=True, null=True)
    activity_multiplier = models.DecimalField(max_digits=4, decimal_places=3)
    health_problems = models.ManyToManyField("HealthProblem", through="SuffersFrom")


    def save(self, *args, **kwargs):
        if not self.user_id:  # generate only for new users
            self.user_id = self._generate_user_id()
        super().save(*args, **kwargs)

    @classmethod
    def _generate_user_id(cls):
        last_id = cls.objects.aggregate(max_id=Max('user_id'))["max_id"]
        if not last_id:
            return "U001"
        match = re.search(r'U(\d+)', last_id)
        if match:
            num = int(match.group(1))
        else:
            num = 0
        return f"U{num+1:03d}"

    def __str__(self):
        return f"{self.user_id} - {self.name}"

    class Meta:
        managed = False
        db_table = 'user'


class Dietplan(models.Model):
    diet_plan_id = models.CharField(primary_key=True, max_length=100)
    date = models.DateField()
    meal = models.CharField(max_length=10)
    total_calories = models.FloatField()
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    foods = models.ManyToManyField("FoodNutrition", through="Includes")

    class Meta:
        managed = False
        db_table = 'dietplan'

    def __str__(self):
        return f"{self.diet_plan_id} ({self.user.name} - {self.date} - {self.meal})"


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

    def __str__(self):
        return f"{self.exercise_name} ({self.type})"


class HealthProblem(models.Model):
    health_id = models.CharField(primary_key=True, max_length=100)
    problem_name = models.CharField(max_length=100)
    description = models.CharField(max_length=300)

    class Meta:
        managed = False
        db_table = 'health_problem'

    def __str__(self):
        return self.problem_name


class ExerciseRestriction(models.Model):
    exercise_restriction_id = models.CharField(primary_key=True, max_length=100)
    e_reason = models.CharField(max_length=100)
    e_severity = models.CharField(max_length=30)
    health = models.ForeignKey(HealthProblem, on_delete=models.CASCADE)
    exercises = models.ManyToManyField("Exercise", through="AppliesTo")

    class Meta:
        managed = False
        db_table = 'exercise_restriction'

    def __str__(self):
        return f"{self.e_reason} ({self.e_severity})"


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

    def __str__(self):
        return self.food_name


class FoodRestriction(models.Model):
    food_restriction_id = models.CharField(primary_key=True, max_length=100)
    f_reason = models.CharField(max_length=100)
    f_severity = models.CharField(max_length=30)
    health = models.ForeignKey(HealthProblem, on_delete=models.CASCADE)
    foods = models.ManyToManyField("FoodNutrition", through="Affects")

    class Meta:
        managed = False
        db_table = 'food_restriction'

    def __str__(self):
        return f"{self.f_reason} ({self.f_severity})"


class Affects(models.Model):
    food_restriction = models.ForeignKey(FoodRestriction, on_delete=models.CASCADE)
    food = models.ForeignKey(FoodNutrition, on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'affects'
        unique_together = (('food_restriction', 'food'),)

    def __str__(self):
        return f"{self.food_restriction} -> {self.food}"


class AppliesTo(models.Model):
    exercise_restriction = models.ForeignKey(ExerciseRestriction, on_delete=models.CASCADE)
    exercise = models.ForeignKey(Exercise, on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'applies_to'
        unique_together = (('exercise_restriction', 'exercise'),)

    def __str__(self):
        return f"{self.exercise_restriction} -> {self.exercise}"


class Includes(models.Model):
    diet_plan = models.ForeignKey(Dietplan, on_delete=models.CASCADE)
    food = models.ForeignKey(FoodNutrition, on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'includes'
        unique_together = (('diet_plan', 'food'),)

    def __str__(self):
        return f"{self.diet_plan} -> {self.food}"


class SuffersFrom(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    health = models.ForeignKey(HealthProblem, on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'suffers_from'
        unique_together = (('user', 'health'),)

    def __str__(self):
        return f"{self.user} -> {self.health}"


# Create your models here.
