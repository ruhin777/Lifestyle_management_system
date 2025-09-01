def to_float(x):
    return float(x) if x is not None else None


def calculate_bmi(weight, height):
    w = to_float(weight); h = to_float(height)
    if not w or not h:
        return None
   
    return round(w / (h ** 2), 2)


def bmi_category(bmi):
    if bmi is None:
        return "No data"
    if bmi < 18.5: return "Underweight"
    if bmi < 25:   return "Healthy weight"
    if bmi < 30:   return "Overweight"
    return "Obese"


def calculate_bmr(weight, height, age, gender):
    w = to_float(weight); h = to_float(height)
    if not w or not h or not age or not gender:
        return None
    # Mifflin–St Jeor (metric)
    if str(gender).lower() == "male":
        bmr = 88.36 + (13.4 * w) + (4.8 * h*100) - (5.7 * int(age))
    else:
        bmr = 447.6 + (9.2 * w) + (3.1 * h * 100) - (4.3 * int(age))
    return round(bmr, 2)