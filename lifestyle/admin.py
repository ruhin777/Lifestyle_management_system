from django.contrib import admin
from .models import (
    User, Dietplan, Exercise, HealthProblem, ExerciseRestriction,
    FoodNutrition, FoodRestriction, Affects, AppliesTo, Includes, SuffersFrom, FoodPreference, ExercisePreference
)


@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    list_display = ("user_id", "name", "email", "age", "gender", "height", "weight", "activity_level")
    search_fields = ("user_id", "name", "email")
    list_filter = ("gender", "activity_level")
    filter_horizontal = ("health_problems",)


@admin.register(Dietplan)
class DietplanAdmin(admin.ModelAdmin):
    list_display = ("diet_plan_id", "date", "meal", "total_calories", "user")
    list_filter = ("meal", "date")
    search_fields = ("diet_plan_id", "user__name")
    filter_horizontal = ("foods",)


@admin.register(Exercise)
class ExerciseAdmin(admin.ModelAdmin):
    list_display = ("exercise_id", "exercise_name", "type", "calories_burned_per_hour", "user")
    search_fields = ("exercise_id", "exercise_name", "type")
    list_filter = ("type", "user")


@admin.register(HealthProblem)
class HealthProblemAdmin(admin.ModelAdmin):
    list_display = ("health_id", "problem_name", "description")
    search_fields = ("problem_name",)


@admin.register(ExerciseRestriction)
class ExerciseRestrictionAdmin(admin.ModelAdmin):
    list_display = ("exercise_restriction_id", "e_reason", "e_severity", "health")
    list_filter = ("e_severity",)
    filter_horizontal = ("exercises",)


@admin.register(FoodNutrition)
class FoodNutritionAdmin(admin.ModelAdmin):
    list_display = ("food_id", "food_name", "calories_100g", "protein_100g", "fat_100g", "carbs_100g", "user")
    search_fields = ("food_name",)
    list_filter = ("user",)


@admin.register(FoodRestriction)
class FoodRestrictionAdmin(admin.ModelAdmin):
    list_display = ("food_restriction_id", "f_reason", "f_severity", "health")
    list_filter = ("f_severity",)
    filter_horizontal = ("foods",)


@admin.register(Affects)
class AffectsAdmin(admin.ModelAdmin):
    list_display = ("id", "food_restriction", "food")
    search_fields = ("food__food_name", "food_restriction__f_reason")


@admin.register(AppliesTo)
class AppliesToAdmin(admin.ModelAdmin):
    list_display = ("id", "exercise_restriction", "exercise")
    search_fields = ("exercise__exercise_name", "exercise_restriction__e_reason")


@admin.register(Includes)
class IncludesAdmin(admin.ModelAdmin):
    list_display = ("id", "diet_plan", "food")
    search_fields = ("diet_plan__diet_plan_id", "food__food_name")


@admin.register(SuffersFrom)
class SuffersFromAdmin(admin.ModelAdmin):
    list_display = ("id", "user", "health")
    search_fields = ("user__name", "health__problem_name")


@admin.register(FoodPreference)
class FoodPreferenceAdmin(admin.ModelAdmin):
    list_display = ("id", "user", "food", "allowed")
    list_filter = ("allowed", "user")
    search_fields = ("food__food_name", "user__name")


@admin.register(ExercisePreference)
class ExercisePreferenceAdmin(admin.ModelAdmin):
    list_display = ("id", "user", "exercise", "allowed")
    list_filter = ("allowed", "user")
    search_fields = ("exercise__exercise_name", "user__name")

# Register your models here.
