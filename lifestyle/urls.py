
from django.urls import path
from . import views

urlpatterns = [
    path("", views.login_view, name="login"),
    path("register/", views.register_view, name="register"),
    path("fill-info/", views.fill_info_view, name="fill_info"),
    path("main_page/", views.main_page, name="main_page"),
    path("bmi_bmr/", views.bmi_bmr_view, name="bmi_bmr"),
    path("daily_calories/", views.daily_calories_view, name="daily_calories"),
    path("food-search/", views.food_search, name="food_search"),
    path("daily-tip/", views.daily_tip, name="daily_tip"),
]
