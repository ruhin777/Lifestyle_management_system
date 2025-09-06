
from django.urls import path
from . import views

urlpatterns = [
    path("", views.welcome, name="welcome"),
    path("login/", views.login_view, name="login"),
    path("register/", views.register_view, name="register"),
    path("fill-info/", views.fill_info_view, name="fill_info"),
    path("main_page/", views.main_page, name="main_page"),
    path("bmi_bmr/", views.bmi_bmr_view, name="bmi_bmr"),
    path("daily_calories/", views.daily_calories_view, name="daily_calories"),
    path("food-search/", views.food_search, name="food_search"),
    path("daily-tip/", views.daily_tip, name="daily_tip"),
    path("exercise-recommendations/<str:user_id>/", views.get_exercise_recommendations, name="exercise_recommendations"),
    path("health_problem/", views.search_health_problem, name="health_problem"),
    path("select_h_prob/<str:health_id>/", views.select_health_problem, name="select_h_prob"),
    path("restriction/<str:health_id>/", views.view_restrictions, name="restriction"),
    path("preferences/", views.user_preferences, name="user_preferences"),
    path('diet-chart/', views.generate_diet_chart, name='generate_diet_chart'),
    path('regenerate-meal-plan/', views.regenerate_meal_plan, name='regenerate_meal_plan'),
    path('view-preferences/', views.view_food_preferences, name='view_preferences'),
    path("logout/", views.logout_view, name="logout"),
    path("profile/", views.profile, name="profile"),
    path("profile/edit/", views.profile_edit, name="profile_edit"),
    path("profile/change-password/", views.profile_change_password, name="profile_password"),
    path("profile/health/", views.profile_health, name="profile_health"),
    path("profile/meal-plans/", views.profile_meal_plans, name="profile_meal_plans"),
    path("profile/exercises/", views.profile_exercises, name="profile_exercises"),
    path("accounts/login/", views.login_view, name="accounts_login")
]

