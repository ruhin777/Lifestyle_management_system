from django.shortcuts import render, redirect
from django.contrib import messages
from .models import User
from .forms import RegisterForm, LoginForm, UserInputForm
from .models import FoodNutrition
import datetime, random
from django.contrib.auth.decorators import login_required
from .utils import calculate_bmi, bmi_category, calculate_bmr


def register_view(request):
    if request.method == "POST":
        form = RegisterForm(request.POST)
        if form.is_valid():
            # Save name+password in session temporarily
            request.session['reg_name'] = form.cleaned_data['name']
            request.session['reg_password'] = form.cleaned_data['password']
            return redirect("fill_info")
    else:
        form = RegisterForm()
    return render(request, "register.html", {"form": form})


def fill_info_view(request):
    reg_name = request.session.get("reg_name")
    reg_password = request.session.get("reg_password")

    if not reg_name or not reg_password:
        return redirect("register")  # must register first

    if request.method == "POST":
        form = UserInputForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.name = reg_name
            user.password = reg_password

            # calculate multiplier
            multipliers = {1: 1.2, 2: 1.375, 3: 1.55, 4: 1.725, 5: 1.9}
            user.activity_multiplier = multipliers.get(user.activity_level, 1.2)

            user.save()

            # cleanup session
            request.session.pop("reg_name")
            request.session.pop("reg_password")

            messages.success(request, f"Registration complete! Your User ID is {user.user_id}")
            return redirect("login")
    else:
        form = UserInputForm()

    return render(request, "fill_info.html", {"form": form})


def login_view(request):
    if request.method == "POST":
        form = LoginForm(request.POST)
        if form.is_valid():
            user_id = form.cleaned_data["user_id"]
            password = form.cleaned_data["password"]
            try:
                user = User.objects.get(user_id=user_id, password=password)
                request.session["user_id"] = user.user_id
                return redirect("main_page")
            except User.DoesNotExist:
                messages.error(request, "Invalid User ID or Password")
    else:
        form = LoginForm()
    return render(request, "login.html", {"form": form})


def main_page(request):
    user_id = request.session.get("user_id")
    if not user_id:
        return redirect("login")
    user = User.objects.get(user_id=user_id)
    return render(request, "main_page.html", {"user": user})

#RAMISHA ft1
def bmi_bmr_view(request):
    if "user_id" not in request.session:
        return redirect("login")
    user = User.objects.get(user_id=request.session["user_id"])
    bmi = calculate_bmi(user.weight, user.height)
    bmr = calculate_bmr(user.weight, user.height, user.age, user.gender)
    return render(request, "bmi_bmr.html", {"user": user, "bmi": bmi, "bmi_cat": bmi_category(bmi), "bmr": bmr})

#RAMISHA ft2
def daily_calories_view(request):
    try:
        user_id = request.session.get("user_id")
        user = User.objects.get(user_id=user_id)
        # Convert to float
        w = float(user.weight)
        h = float(user.height)
        age = int(user.age)
        gender = str(user.gender).lower()

        # Mifflin–St Jeor Formula
        if gender == "male":
            bmr = 88.36 + (13.4 * w) + (4.8 * (h * 100)) - (5.7 * age)
        else:
            bmr = 447.6 + (9.2 * w) + (3.1 * (h * 100)) - (4.3 * age)

        # Convert Decimal to float for multiplication
        activity_multiplier = float(user.activity_multiplier)
        daily_calories = bmr * activity_multiplier

        # Save in DB
        user.daily_calories = daily_calories
        user.save()

        return render(request, "daily_calories.html", {
            "user": user,
            "daily_calories": round(daily_calories, 2)
        })

    except User.DoesNotExist:
        messages.error(request, "User not found. Please log in again.")
        return redirect("login")

#RUHIN ft1
def food_search(request):
    query = request.GET.get('q', '').strip()
    results = []

    if query:
        results = FoodNutrition.objects.filter(food_name__icontains=query)

    context = {
        "query": query,
        "results": results,
    }
    return render(request, "food_search.html", context)

#NAJIBA ft1
@login_required
def daily_tip(request):
    user_id = request.session.get("user_id")
    try:
        profile = User.objects.get(user_id=user_id)
    except User.DoesNotExist:
        profile = None

    if profile:
        bmi = calculate_bmi(float(profile.weight), float(profile.height))
        category = bmi_category(bmi)
    else:
        bmi = 0
        category = "No data"

    tips = {
        "Underweight": [
            "🍗 Add healthy calorie-dense foods like nuts and dairy.",
            "🥛 Drink smoothies between meals to boost calories."
        ],
        "Healthy weight": [
            "💧 Keep hydrated and stay active daily.",
            "🥗 Maintain a balanced diet with enough protein."
        ],
        "Overweight": [
            "🚶 Walk 30 mins daily or take stairs instead of elevators.",
            "🍵 Replace sugary drinks with water or herbal tea."
        ],
        "Obese": [
            "🏊 Try low-impact exercises like swimming or cycling.",
            "🥦 Focus on vegetables and high-fiber foods."
        ],
        "No data": [
            "📊 Please update your profile with height and weight."
        ]
    }

    # Fix tip category if BMI not calculated
    chosen_tips = tips.get(category, tips["No data"])

    # One tip per day (same for whole day per user)
    today = datetime.date.today()
    random.seed(today.toordinal() + hash(request.user.username))
    tip = random.choice(chosen_tips)


    return render(request, "daily_tip.html", {
        "tip": tip,
    })

# Create your views here.
