from django import forms
from .models import User

class RegisterForm(forms.Form):
    name = forms.CharField(max_length=100)
    password = forms.CharField(widget=forms.PasswordInput)
    confirm_password = forms.CharField(widget=forms.PasswordInput)

    def clean(self):
        cleaned_data = super().clean()
        if cleaned_data.get("password") != cleaned_data.get("confirm_password"):
            raise forms.ValidationError("Passwords do not match")
        return cleaned_data


class UserInputForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ["age", "gender", "height", "weight", "activity_level"]

        labels = {
            "height": "Height (in m)",
            "weight": "Weight (in kg)",
        }

        help_texts = {
            "height": "Enter your height in meters (e.g., 1.70).",
            "weight": "Enter your weight in kilograms (e.g., 65).",
        }

        widgets = {
            "activity_level": forms.Select(choices=[
                (1, "Level 1 - Little or no exercise"),
                (2, "Level 2 - Exercise 1–3 times per week"),
                (3, "Level 3 - Exercise 3–5 times per week"),
                (4, "Level 4 - Exercise 6–7 times per week"),
                (5, "Level 5 - Very active (hard exercise & physical job)"),
            ])
        }


class LoginForm(forms.Form):
    user_id = forms.CharField()
    password = forms.CharField(widget=forms.PasswordInput)
