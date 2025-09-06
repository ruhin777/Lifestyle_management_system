from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from .models import User, FoodNutrition, Exercise, ExerciseRestriction, HealthProblem, SuffersFrom, FoodRestriction, Affects, AppliesTo, FoodPreference, ExercisePreference, Includes, Dietplan
from .forms import RegisterForm, LoginForm, UserInputForm, EditUserForm, ChangePasswordForm
import datetime, random
from datetime import date
from django.urls import reverse
from django.contrib.auth.decorators import login_required
from .utils import calculate_bmi, bmi_category, calculate_bmr
from django.db.models import Q
from .meal_utils import generate_meal_plan, generate_diet_plan_id


def welcome(request):
    return render(request, "welcome.html")


def register_view(request):
    if request.method == "POST":
        form = RegisterForm(request.POST)
        if form.is_valid():
            # Save name+password in session temporarily
            request.session['reg_name'] = form.cleaned_data['name']
            request.session['reg_email'] = form.cleaned_data['email'] 
            request.session['reg_password'] = form.cleaned_data['password']
            return redirect("fill_info")
    else:
        form = RegisterForm()
    return render(request, "register.html", {"form": form})


def fill_info_view(request):
    reg_name = request.session.get("reg_name")
    reg_email = request.session.get("reg_email")
    reg_password = request.session.get("reg_password")

    if not reg_name or not reg_password or not reg_email:
        return redirect("register")  # must register first

    if request.method == "POST":
        form = UserInputForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.name = reg_name
            user.email = reg_email 
            user.password = reg_password

            # calculate multiplier
            multipliers = {1: 1.2, 2: 1.375, 3: 1.55, 4: 1.725, 5: 1.9}
            user.activity_multiplier = multipliers.get(user.activity_level, 1.2)

            user.save()

            # cleanup session
            request.session.pop("reg_name")
            request.session.pop("reg_email")
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
        # 🔥 Macronutrient Breakdown
        protein_cal = daily_calories * 0.20  # 20%
        carbs_cal = daily_calories * 0.50    # 50%
        fats_cal = daily_calories * 0.30     # 30%


        macros = {
            "protein_g": round(protein_cal / 4, 1),  # 1g protein = 4 kcal
            "carbs_g": round(carbs_cal / 4, 1),      # 1g carb = 4 kcal
            "fats_g": round(fats_cal / 9, 1),        # 1g fat = 9 kcal
        }


        return render(request, "daily_calories.html", {
            "user": user,
            "daily_calories": round(daily_calories, 2),
            "macros": macros
        })


    except User.DoesNotExist:
        messages.error(request, "User not found. Please log in again.")
        return redirect("login")
    
#RAMISHA ft3
# 🔎 1. Search Health Problem
@login_required
def search_health_problem(request):
    query = request.GET.get("q", "").strip()
    results = []


    if query:
        results = HealthProblem.objects.filter(
            Q(problem_name__icontains=query) |
            Q(description__icontains=query) |
            Q(foodrestriction__foods__food_name__icontains=query) |
            Q(exerciserestriction__exercises__exercise_name__icontains=query)
        ).distinct()


    return render(request, "health_problem.html", {
        "query": query,
        "results": results
    })

# ✅ 2. Select a Health Problem
@login_required
def select_health_problem(request, health_id):
    health = get_object_or_404(HealthProblem, pk=health_id)
  #  user = request.user # Use the currently logged-in user
    user_id = request.session.get("user_id")
    user = get_object_or_404(User, user_id=user_id)


    if request.method == "POST":
        suff, created = SuffersFrom.objects.get_or_create(user=user, health=health)


        if created:
            messages.success(request, f"{health.problem_name} added to your profile.")
        else:
            messages.info(request, f"{health.problem_name} is already in your profile.")


        return redirect("restriction", health_id=health.health_id)


    return render(request, "select_h_prob.html", {"health": health})

# 🚫 3. View Restrictions
@login_required
def view_restrictions(request, health_id):
    health = get_object_or_404(HealthProblem, pk=health_id)


    # Get food restrictions
    food_restrictions = Affects.objects.filter(
        food_restriction__health=health
    ).select_related("food_restriction", "food")


    # Get exercise restrictions
    exercise_restrictions = AppliesTo.objects.filter(
        exercise_restriction__health=health
    ).select_related("exercise_restriction", "exercise")


    return render(request, "restriction.html", {
        "health": health,
        "food_restrictions": food_restrictions,
        "exercise_restrictions": exercise_restrictions
    })


#RUHIN ft1
def generate_diet_chart(request):
    user_id = request.session.get('user_id')
    if not user_id:
        messages.error(request, "Please log in to generate a diet chart.")
        return redirect('login')
    
    user = get_object_or_404(User, user_id=user_id)
    
    if not user.daily_calories:
        messages.error(request, "Please calculate your daily calories first before generating a meal plan.")
        return redirect('daily_calories')
    
    health_problems = SuffersFrom.objects.filter(user=user)
    if not health_problems.exists():
        messages.error(request, "Please set your health problems first to generate a personalized meal plan.")
        return redirect('health_problem')
    
    food_preferences = FoodPreference.objects.filter(user=user)
    if not food_preferences.exists():
        messages.error(request, "Please set your food preferences first to generate a personalized meal plan.")
        return redirect('user_preferences')
    
    meal_plan = None
    total_calories = 0
    
    try:
        recent_plans = Dietplan.objects.filter(user=user, date=date.today())
        
        if recent_plans.exists():
            meal_plan = {}
            for plan in recent_plans:
                meal = plan.meal
                if meal not in meal_plan:
                    meal_plan[meal] = {'foods': [], 'total_calories': 0}
                
                includes = Includes.objects.filter(diet_plan=plan)
                for include in includes:
                    food = include.food
                    portion_size = (plan.total_calories / food.calories_100g) * 100 if food.calories_100g else 0
                    
                    meal_plan[meal]['foods'].append({
                        'food': food,
                        'portion_size': round(portion_size, 1),
                        'calories': round(plan.total_calories, 2)
                    })
                    meal_plan[meal]['total_calories'] += plan.total_calories
                    total_calories += plan.total_calories
        else:
            meal_plan, total_calories = generate_meal_plan(user)
            
            for meal, details in meal_plan.items():
                for food_item in details['foods']:
                    diet_plan = Dietplan.objects.create(
                        diet_plan_id=generate_diet_plan_id(),
                        date=date.today(),
                        meal=meal,
                        total_calories=food_item['calories'],
                        user=user
                    )
                    
                    Includes.objects.create(
                        diet_plan=diet_plan,
                        food=food_item['food']
                    )
        
        context = {
            'user': user,
            'meal_plan': meal_plan,
            'total_calories': total_calories,
            'meals': ['Breakfast', 'Lunch', 'Dinner', 'Snack'] if meal_plan else []
        }
        
        return render(request, 'diet_chart.html', context)
        
    except ValueError as e:
        messages.error(request, str(e))
        return redirect('main_page')
    except Exception as e:
        messages.error(request, f"Error generating meal plan: {str(e)}")
        return redirect('main_page')

def regenerate_meal_plan(request):
    user_id = request.session.get('user_id')
    if not user_id:
        messages.error(request, "Please log in to generate a diet chart.")
        return redirect('login')
    
    user = get_object_or_404(User, user_id=user_id)
    Dietplan.objects.filter(user=user, date=date.today()).delete()
    return redirect('generate_diet_chart')

def view_food_preferences(request):
    user_id = request.session.get('user_id')
    if not user_id:
        messages.error(request, "Please log in to view food preferences.")
        return redirect('login')
    
    user = get_object_or_404(User, user_id=user_id)
    preferences = FoodPreference.objects.filter(user=user)
    
    context = {
        'preferences': preferences,
        'user': user
    }
    
    return render(request, 'view_preferences.html', context)

#RUHIN ft2
def get_exercise_recommendations(request, user_id):
    user = get_object_or_404(User, user_id=user_id)
    bmi = calculate_bmi(user.weight, user.height)
    health_conditions = user.health_problems.all()  


    user_exercise_preferences = ExercisePreference.objects.filter(user=user, allowed=True)
    preferred_exercise_ids = [pref.exercise.exercise_id for pref in user_exercise_preferences]

    exercises = Exercise.objects.filter(min_bmi__lte=bmi, max_bmi__gte=bmi)

    if health_conditions.exists():
        exercises = exercises.exclude(
            appliesto__exercise_restriction__in=(
                ExerciseRestriction.objects.filter(health__in=health_conditions)
            )
        ).distinct()


    if preferred_exercise_ids:
   
        exercises = list(exercises)
        exercises.sort(key=lambda x: x.exercise_id not in preferred_exercise_ids)
        
     
        exercises = exercises[:5]
    else:
        exercises = exercises[:5]

    context = {
        'user': user,
        'exercises': exercises
    }

    return render(request, 'exercise_recommendations.html', context)

#RUHIN ft3
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
def _current_user(request):
    """
    Resolve the currently 'logged in' custom user from the session.
    Your login_view should set: request.session['user_id'] = user.user_id
    """
    user_id = request.session.get("user_id")
    if not user_id:
        messages.info(request, "Please log in to manage your preferences.")
        return None
    try:
        return User.objects.get(pk=user_id)
    except User.DoesNotExist:
        messages.error(request, "Your account was not found. Please log in again.")
        return None
   


def user_preferences(request):
    user = _current_user(request)
    if not user:
        return redirect("login")   # ✅ don’t fall back to user1



    saved_foods = FoodPreference.objects.filter(user=user).select_related("food")
    saved_exercises = ExercisePreference.objects.filter(user=user).select_related("exercise")


    ctx_base = {
        "saved_foods": saved_foods,
        "saved_exercises": saved_exercises,
        "warning": None,       
    }


    if request.method == "POST":
        # --- Food search ---
        if "food_search" in request.POST:
            query = (request.POST.get("food_search") or "").strip()
            foods = FoodNutrition.objects.filter(food_name__icontains=query) if query else []
            return render(request, "preferences.html", {
                **ctx_base, "foods": foods, "exercises": None
            })


        # --- Exercise search ---
        if "exercise_search" in request.POST:
            query = (request.POST.get("exercise_search") or "").strip()
            exercises = Exercise.objects.filter(exercise_name__icontains=query) if query else []
            return render(request, "preferences.html", {
                **ctx_base, "foods": None, "exercises": exercises
            })


        # --- Add food ---
        if "add_food" in request.POST:
            food_id = request.POST.get("food_id")
            try:
                food = FoodNutrition.objects.get(pk=food_id)
            except FoodNutrition.DoesNotExist:
                messages.error(request, "Selected food no longer exists.")
                return redirect("user_preferences")


            # Check restrictions for this user
            restrictions = FoodRestriction.objects.filter(
                foods=food, health__in=user.health_problems.all()
            ).distinct()


            allowed = not restrictions.exists()
            if restrictions.exists():
                severities = ", ".join(sorted({r.f_severity for r in restrictions}))
                reasons = ", ".join(sorted({r.f_reason for r in restrictions}))
                # show warning and still allow add
                messages.warning(
                    request,
                    f"{food.food_name} may be restricted ({severities}). Risks: {reasons}. "
                    "You can still add it."
                )


            pref, created = FoodPreference.objects.get_or_create(
                user=user, food=food, defaults={"allowed": allowed}
            )
            if not created and pref.allowed != allowed:
                pref.allowed = allowed
                pref.save(update_fields=["allowed"])


            messages.success(request, f"Added {food.food_name} to your foods.")
            return redirect("user_preferences")


        # --- Add exercise ---
        if "add_exercise" in request.POST:
            exercise_id = request.POST.get("exercise_id")
            try:
                exercise = Exercise.objects.get(pk=exercise_id)
            except Exercise.DoesNotExist:
                messages.error(request, "Selected exercise no longer exists.")
                return redirect("user_preferences")


            restrictions = ExerciseRestriction.objects.filter(
                exercises=exercise, health__in=user.health_problems.all()
            ).distinct()


            allowed = not restrictions.exists()
            if restrictions.exists():
                severities = ", ".join(sorted({r.e_severity for r in restrictions}))
                reasons = ", ".join(sorted({r.e_reason for r in restrictions}))
                messages.warning(
                    request,
                    f"{exercise.exercise_name} may be restricted ({severities}). Risks: {reasons}. "
                    "You can still add it."
                )


            pref, created = ExercisePreference.objects.get_or_create(
                user=user, exercise=exercise, defaults={"allowed": allowed}
            )
            if not created and pref.allowed != allowed:
                pref.allowed = allowed
                pref.save(update_fields=["allowed"])


            messages.success(request, f"Added {exercise.exercise_name} to your exercises.")
            return redirect("user_preferences")


        # --- Delete food (only this user’s row) ---
        if "delete_food" in request.POST:
            deleted, _ = FoodPreference.objects.filter(
                id=request.POST.get("delete_food"), user=user
            ).delete()
            if deleted:
                messages.info(request, "Removed food.")
            return redirect("user_preferences")


        # --- Delete exercise (only this user’s row) ---
        if "delete_exercise" in request.POST:
            deleted, _ = ExercisePreference.objects.filter(
                id=request.POST.get("delete_exercise"), user=user
            ).delete()
            if deleted:
                messages.info(request, "Removed exercise.")
            return redirect("user_preferences")


        # Unknown POST: just reload
        return redirect("user_preferences")


    # GET
    return render(request, "preferences.html", {
        **ctx_base, "foods": None, "exercises": None
    })

#NAJIBA ft2
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

#NAJIBA ft3
def logout_view(request):
    if request.method == "POST":
        request.session.flush()
        messages.info(request, "Logged out.")
    return redirect("login")


def profile(request):
    user = _current_user(request)
    if not user:
        return redirect("login")


    # quick aggregates/info
    health_list = user.health_problems.all().order_by("problem_name")
    meal_count = Dietplan.objects.filter(user=user).count()
    ex_pref_count = ExercisePreference.objects.filter(user=user).count()


    return render(request, "profile.html", {
        "user_obj": user,
        "health_list": health_list,
        "meal_count": meal_count,
        "ex_pref_count": ex_pref_count,
    })


def profile_edit(request):
    user = _current_user(request)
    if not user:
        return redirect("login")


    if request.method == "POST":
        form = EditUserForm(request.POST, instance=user)
        if form.is_valid():
            form.save()
            messages.success(request, "Profile updated.")
            return redirect("profile")
    else:
        form = EditUserForm(instance=user)


    return render(request, "profile_edit.html", {"form": form})


def profile_change_password(request):
    user = _current_user(request)
    if not user:
        return redirect("login")


    if request.method == "POST":
        form = ChangePasswordForm(request.POST)
        if form.is_valid():
            cp = form.cleaned_data["current_password"]
            if user.password != cp:
                messages.error(request, "Current password is incorrect.")
            else:
                user.password = form.cleaned_data["new_password"]
                user.save(update_fields=["password"])
                messages.success(request, "Password changed.")
                return redirect("profile")
    else:
        form = ChangePasswordForm()


    return render(request, "profile_change_password.html", {"form": form})


def profile_health(request):
    user = _current_user(request)
    if not user:
        return redirect("login")


    # Remove a health problem (unlink)
    if request.method == "POST" and "delete_health" in request.POST:
        hid = request.POST.get("delete_health")
        SuffersFrom.objects.filter(user=user, health_id=hid).delete()
        messages.info(request, "Health problem removed.")
        return redirect("profile_health")


    healths = user.health_problems.all().order_by("problem_name")
    return render(request, "profile_health.html", {"healths": healths})


def profile_meal_plans(request):
    user = _current_user(request)
    if not user:
        return redirect("login")


    if request.method == "POST" and "remove_food" in request.POST:
        dp_id = request.POST.get("plan_id")    # Dietplan PK (diet_plan_id)
        food_id = request.POST.get("food_id")  # FoodNutrition PK (food_id)
        q_date = request.POST.get("q_date") or ""


        # Only allow deleting from the current user's plan
        if not Dietplan.objects.filter(diet_plan_id=dp_id, user=user).exists():
            messages.error(request, "You cannot modify this meal plan.")
            if q_date:
                return redirect(f"{reverse('profile_meal_plans')}?date={q_date}")
            return redirect("profile_meal_plans")


        deleted, _ = Includes.objects.filter(
            diet_plan_id=dp_id,
            food_id=food_id,
        ).delete()


        if deleted:
            messages.info(request, "Removed the food from this meal.")
        else:
            messages.error(request, "Could not remove that item.")


        # Preserve the date filter on return
        if q_date:
            return redirect(f"{reverse('profile_meal_plans')}?date={q_date}")
        return redirect("profile_meal_plans")


    # --- GET flow ---
    q_date = (request.GET.get("date") or "").strip()
    plans = Dietplan.objects.filter(user=user)
    if q_date:
        plans = plans.filter(date=q_date)


    # Prefetch the M2M target, not the through model
    plans = plans.order_by("-date", "meal").prefetch_related("foods")


    return render(request, "profile_meal_plans.html", {"plans": plans, "q_date": q_date})


def profile_exercises(request):
    """
    Lets the user see their saved/recommended exercises and delete them.
    (Assumes 'recommendations' live in ExercisePreference; adapt if you store them elsewhere.)
    """
    user = _current_user(request)
    if not user:
        return redirect("login")


    if request.method == "POST" and "delete_exercise_pref" in request.POST:
        pref_id = request.POST.get("delete_exercise_pref")
        ExercisePreference.objects.filter(id=pref_id, user=user).delete()
        messages.info(request, "Exercise removed from your list.")
        return redirect("profile_exercises")


    prefs = ExercisePreference.objects.filter(user=user).select_related("exercise").order_by("-id")
    return render(request, "profile_exercises.html", {"prefs": prefs})


