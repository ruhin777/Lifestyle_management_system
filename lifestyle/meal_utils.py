# lifestyle/meal_utils.py
from .models import User, FoodNutrition, FoodRestriction, SuffersFrom, FoodPreference, Affects, Dietplan
from django.db.models import Max
import re

def get_user_restrictions(user):
    user_health_problems = SuffersFrom.objects.filter(user=user).values_list('health_id', flat=True)
    food_restrictions = FoodRestriction.objects.filter(health_id__in=user_health_problems)
    
    restricted_food_ids = []
    for restriction in food_restrictions:
        affected_foods = Affects.objects.filter(food_restriction=restriction)
        restricted_food_ids.extend([affect.food.food_id for affect in affected_foods])
    
    return list(set(restricted_food_ids))

def get_user_preferences(user):
    preferences = FoodPreference.objects.filter(user=user)
    preferred_foods = [pref.food for pref in preferences if pref.allowed]
    avoided_foods = [pref.food for pref in preferences if not pref.allowed]
    return preferred_foods, avoided_foods

def categorize_food_by_type(food):
    """
    Categorize foods into: carb, protein, vegetable, fruit, dairy, other
    """
    food_name = food.food_name.lower()
    calories = food.calories_100g
    protein = food.protein_100g
    carbs = food.carbs_100g
    
    # Carbohydrate sources (rice, bread, grains)
    if any(keyword in food_name for keyword in ['rice', 'bhat', 'bread', 'roti', 'pitha', 'shemai', 'vermicelli', 'oat', 'cereal', 'wheat', 'noodle']):
        return 'carb'
    
    # Protein sources (separate breakfast and general proteins)
    if any(keyword in food_name for keyword in ['fish', 'mach', 'chicken', 'meat', 'prawn', 'chingri', 'beef', 'mutton']):
        return 'protein_main'
    if any(keyword in food_name for keyword in ['egg', 'dal', 'lentil', 'bean', 'curry']):
        return 'protein_breakfast'
    
    # Vegetables
    if any(keyword in food_name for keyword in ['vegetable', 'shaak', 'green', 'spinach', 'broccoli', 'potato', 'aloo', 'onion', 'tomato', 'cucumber', 'carrot', 'cabbage', 'cauliflower', 'bean', 'pea']):
        return 'vegetable'
    
    # Fruits
    if any(keyword in food_name for keyword in ['fruit', 'mango', 'banana', 'papaya', 'orange', 'apple', 'berry', 'grape', 'pineapple', 'guava', 'lichi']):
        return 'fruit'
    
    # Dairy
    if any(keyword in food_name for keyword in ['milk', 'dairy', 'yogurt', 'doi', 'cheese', 'paneer', 'curd']):
        return 'dairy'
    
    # Default categorization by nutritional profile
    if carbs >= 15 and protein < 10:
        return 'carb'
    elif protein >= 8:
        return 'protein_main'  # Default to main protein
    elif calories <= 50:
        return 'vegetable'
    
    return 'other'

def generate_meal_plan(user):
    if not user.daily_calories:
        raise ValueError("User does not have daily calories calculated. Please calculate daily calories first.")
    
    daily_calories = user.daily_calories
    
    user_health_problems = SuffersFrom.objects.filter(user=user)
    if not user_health_problems.exists():
        raise ValueError("Please set your health problems first to generate a personalized meal plan.")
    
    user_preferences = FoodPreference.objects.filter(user=user)
    if not user_preferences.exists():
        raise ValueError("Please set your food preferences first to generate a personalized meal plan.")
    
    restricted_food_ids = get_user_restrictions(user)
    preferred_foods, avoided_foods = get_user_preferences(user)
    
    available_foods = FoodNutrition.objects.all().exclude(food_id__in=restricted_food_ids)
    if avoided_foods:
        available_foods = available_foods.exclude(food_id__in=[f.food_id for f in avoided_foods])
    
    # Categorize all available foods
    categorized_foods = {
        'carb': [],
        'protein_breakfast': [],
        'protein_main': [],
        'vegetable': [],
        'fruit': [],
        'dairy': [],
        'other': []
    }
    
    for food in available_foods:
        food_type = categorize_food_by_type(food)
        categorized_foods[food_type].append(food)
    
    # Get user's preferred foods that are not restricted or avoided
    preferred_foods = [f for f in preferred_foods if f.food_id not in restricted_food_ids]
    preferred_food_ids = [f.food_id for f in preferred_foods]
    
    # Define culturally appropriate meal structures
    meal_structures = {
        'Breakfast': [
            ('carb', 0.5),
            ('protein_breakfast', 0.3),
            ('fruit', 0.1),
            ('dairy', 0.1)
        ],
        'Lunch': [
            ('carb', 0.4),
            ('protein_main', 0.35),
            ('vegetable', 0.25)
        ],
        'Dinner': [
            ('carb', 0.35),
            ('protein_main', 0.4),
            ('vegetable', 0.25)
        ],
        'Snack': [
            ('fruit', 0.7),
            ('dairy', 0.3)
        ]
    }
    
    meal_calories = {
        'Breakfast': round(daily_calories * 0.25, 2),
        'Lunch': round(daily_calories * 0.35, 2),
        'Dinner': round(daily_calories * 0.30, 2),
        'Snack': round(daily_calories * 0.10, 2),
    }
    
    meal_plan = {}
    total_calories = 0.0
    preferred_foods_added = set()
    
    # Process each meal
    for meal, target_calories in meal_calories.items():
        meal_foods = []
        current_meal_calories = 0.0
        meal_structure = meal_structures[meal]
        
        # Track if we've already added a carb for this meal
        carb_added = False
        
        # STEP 1: Add user's preferred foods first (if they fit the meal type)
        for food_type, ratio in meal_structure:
            type_target_calories = target_calories * ratio
            
            # Skip carbs if we've already added one for this meal
            if food_type == 'carb' and carb_added:
                continue
                
            # Find preferred foods that match this meal type
            for preferred_food in preferred_foods:
                if (preferred_food.food_id not in preferred_foods_added and 
                    preferred_food.food_id not in restricted_food_ids):
                    
                    preferred_food_type = categorize_food_by_type(preferred_food)
                    if preferred_food_type == food_type:
                        food_calories = preferred_food.calories_100g
                        
                        if food_calories <= 0:
                            continue
                            
                        # Calculate portion size to meet calorie target
                        if preferred_food_type == 'carb':
                            base_portion = (type_target_calories / food_calories) * 100
                            portion_size = max(80, min(200, base_portion))
                            carb_added = True
                        elif preferred_food_type.startswith('protein'):
                            base_portion = (type_target_calories / food_calories) * 100
                            portion_size = max(60, min(180, base_portion))
                        elif preferred_food_type == 'vegetable':
                            base_portion = (type_target_calories / food_calories) * 100
                            portion_size = max(100, min(250, base_portion))
                        elif preferred_food_type == 'fruit':
                            base_portion = (type_target_calories / food_calories) * 100
                            portion_size = max(100, min(200, base_portion))
                        elif preferred_food_type == 'dairy':
                            base_portion = (type_target_calories / food_calories) * 100
                            portion_size = max(100, min(200, base_portion))
                        else:
                            base_portion = (type_target_calories / food_calories) * 100
                            portion_size = max(50, min(150, base_portion))
                        
                        portion_calories = round((portion_size / 100) * food_calories, 2)
                        
                        if current_meal_calories + portion_calories <= target_calories * 1.1:
                            meal_foods.append({
                                'food': preferred_food,
                                'portion_size': round(portion_size, 1),
                                'calories': portion_calories
                            })
                            current_meal_calories = round(current_meal_calories + portion_calories, 2)
                            preferred_foods_added.add(preferred_food.food_id)
                            
                            # Remove from categorized foods to avoid duplicates
                            categorized_foods[preferred_food_type] = [
                                f for f in categorized_foods[preferred_food_type] 
                                if f.food_id != preferred_food.food_id
                            ]
        
        # STEP 2: Fill remaining calories with other available foods to meet at least 90% target
        for food_type, ratio in meal_structure:
            remaining_calories = max(0, target_calories - current_meal_calories)
            if remaining_calories < target_calories * 0.1:  # Already reached 90%
                continue
                
            type_target_calories = remaining_calories * ratio
            available_type_foods = categorized_foods[food_type].copy()
            
            # Skip carbs if we've already added one for this meal
            if food_type == 'carb' and carb_added:
                continue
                
            if not available_type_foods:
                continue
                
            # Add only ONE food of each type
            foods_added = 0
            max_foods_per_type = 1
            
            while (current_meal_calories < target_calories * 0.9 and  # Ensure at least 90%
                   foods_added < max_foods_per_type and 
                   available_type_foods):
                
                # Prioritize foods that are in user's preferences
                available_type_foods.sort(key=lambda x: x.food_id not in preferred_food_ids)
                food = available_type_foods[0]
                
                food_calories = food.calories_100g
                
                if food_calories <= 0:
                    continue
                    
                # Calculate portion size to meet remaining calorie needs
                remaining_type_calories = type_target_calories
                base_portion = (remaining_type_calories / food_calories) * 100
                
                if food_type == 'carb':
                    portion_size = max(80, min(200, base_portion))
                    carb_added = True
                elif food_type.startswith('protein'):
                    portion_size = max(60, min(180, base_portion))
                elif food_type == 'vegetable':
                    portion_size = max(100, min(250, base_portion))
                elif food_type == 'fruit':
                    portion_size = max(100, min(200, base_portion))
                elif food_type == 'dairy':
                    portion_size = max(100, min(200, base_portion))
                else:
                    portion_size = max(50, min(150, base_portion))
                
                portion_calories = round((portion_size / 100) * food_calories, 2)
                
                if current_meal_calories + portion_calories <= target_calories * 1.1:
                    meal_foods.append({
                        'food': food,
                        'portion_size': round(portion_size, 1),
                        'calories': portion_calories
                    })
                    current_meal_calories = round(current_meal_calories + portion_calories, 2)
                    foods_added += 1
                    
                    # Remove this food to avoid duplicates
                    available_type_foods = [f for f in available_type_foods if f.food_id != food.food_id]
                    categorized_foods[food_type] = [f for f in categorized_foods[food_type] if f.food_id != food.food_id]
                else:
                    break
        
        # Ensure we meet at least 90% of target calories for this meal
        if current_meal_calories < target_calories * 0.9:
            # Add small portions of available foods to meet minimum
            for food_type in ['carb', 'protein_breakfast', 'protein_main', 'fruit', 'dairy']:
                if current_meal_calories >= target_calories * 0.9:
                    break
                    
                available_type_foods = categorized_foods[food_type].copy()
                if available_type_foods:
                    food = available_type_foods[0]
                    food_calories = food.calories_100g
                    
                    if food_calories > 0:
                        # Add small portion to meet the 90% target
                        needed_calories = target_calories * 0.9 - current_meal_calories
                        portion_size = max(20, (needed_calories / food_calories) * 100)
                        portion_calories = round((portion_size / 100) * food_calories, 2)
                        
                        meal_foods.append({
                            'food': food,
                            'portion_size': round(portion_size, 1),
                            'calories': portion_calories
                        })
                        current_meal_calories = round(current_meal_calories + portion_calories, 2)
        
        meal_plan[meal] = {
            'foods': meal_foods,
            'total_calories': round(current_meal_calories, 2)
        }
    
    # Calculate total calories by summing all meal totals (ensures proper rounding)
    total_calories = round(sum(meal['total_calories'] for meal in meal_plan.values()), 2)
    
    return meal_plan, total_calories

def generate_diet_plan_id():
    last_id = Dietplan.objects.aggregate(max_id=Max('diet_plan_id'))["max_id"]
    if not last_id:
        return "DP001"
    match = re.search(r'DP(\d+)', last_id)
    if match:
        num = int(match.group(1))
    else:
        num = 0
    return f"DP{num+1:03d}"