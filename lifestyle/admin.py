from django.contrib import admin

from .models import (
    User, Dietplan, Exercise, HealthProblem, ExerciseRestriction,
    FoodNutrition, FoodRestriction, Affects, AppliesTo,
    Includes, SuffersFrom
)


@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    list_display = ("user_id", "name", "age", "gender", "height", "weight", "activity_level")
    search_fields = ("user_id", "name")
    list_filter = ("gender", "activity_level")


@admin.register(Dietplan)
class DietplanAdmin(admin.ModelAdmin):
    list_display = ("diet_plan_id", "date", "meal", "total_calories", "user")
    list_filter = ("meal", "date")
    search_fields = ("diet_plan_id", "user__name")


@admin.register(Exercise)
class ExerciseAdmin(admin.ModelAdmin):
    list_display = ("exercise_id", "exercise_name", "type", "calories_burned_per_hour", "user")
    search_fields = ("exercise_id", "exercise_name", "type")
    list_filter = ("type",)


@admin.register(HealthProblem)
class HealthProblemAdmin(admin.ModelAdmin):
    list_display = ("health_id", "problem_name", "description")
    search_fields = ("problem_name",)


@admin.register(ExerciseRestriction)
class ExerciseRestrictionAdmin(admin.ModelAdmin):
    list_display = ("exercise_restriction_id", "e_reason", "e_severity", "health")
    list_filter = ("e_severity",)


@admin.register(FoodNutrition)
class FoodNutritionAdmin(admin.ModelAdmin):
    list_display = ("food_id", "food_name", "calories_100g", "protein_100g", "fat_100g", "carbs_100g", "user")
    search_fields = ("food_name",)
    list_filter = ("user",)


@admin.register(FoodRestriction)
class FoodRestrictionAdmin(admin.ModelAdmin):
    list_display = ("food_restriction_id", "f_reason", "f_severity", "health")
    list_filter = ("f_severity",)


@admin.register(Affects)
class AffectsAdmin(admin.ModelAdmin):
    list_display = ("food_restriction", "food")


@admin.register(AppliesTo)
class AppliesToAdmin(admin.ModelAdmin):
    list_display = ("exercise_restriction", "exercise")


@admin.register(Includes)
class IncludesAdmin(admin.ModelAdmin):
    list_display = ("diet_plan", "food")


@admin.register(SuffersFrom)
class SuffersFromAdmin(admin.ModelAdmin):
    list_display = ("user", "health")

# Register your models here.
