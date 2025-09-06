from django import forms
from .models import User

class RegisterForm(forms.Form):
    name = forms.CharField(max_length=100)
    email = forms.CharField(max_length=100)
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

    def clean_age(self):
        age = self.cleaned_data.get("age")
        if age is not None and age <= 0:
            raise forms.ValidationError("Age must be a positive number.")
        return age


    def clean_height(self):
        h = self.cleaned_data.get("height")
        if h is not None and h <= 0:
            raise forms.ValidationError("Height must be greater than 0.")
        return h


    def clean_weight(self):
        w = self.cleaned_data.get("weight")
        if w is not None and w <= 0:
            raise forms.ValidationError("Weight must be greater than 0.")
        return w


class LoginForm(forms.Form):
    user_id = forms.CharField()
    password = forms.CharField(widget=forms.PasswordInput)


class EditUserForm(forms.ModelForm):
    """
    Profile edit: lets the user update their basic information.
    (Email is editable here; password is changed via a separate form.)
    """
    class Meta:
        model = User
        fields = [
            "name",
            "email",
            "age",
            "gender",
            "height",
            "weight",
            "activity_level",
            "activity_multiplier",
        ]


        labels = {
            "height": "Height (in m)",
            "weight": "Weight (in kg)",
            "activity_multiplier": "Activity Multiplier",
        }


        help_texts = {
            "activity_multiplier": "Used with BMR to adjust daily calories (e.g., 1.2 – 1.9).",
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


    # Reuse some simple validations
    def clean_age(self):
        age = self.cleaned_data.get("age")
        if age is not None and age <= 0:
            raise forms.ValidationError("Age must be a positive number.")
        return age


    def clean_height(self):
        h = self.cleaned_data.get("height")
        if h is not None and h <= 0:
            raise forms.ValidationError("Height must be greater than 0.")
        return h


    def clean_weight(self):
        w = self.cleaned_data.get("weight")
        if w is not None and w <= 0:
            raise forms.ValidationError("Weight must be greater than 0.")
        return w


    def clean_activity_multiplier(self):
        am = self.cleaned_data.get("activity_multiplier")
        # allow empty if your DB permits; otherwise enforce a reasonable range
        if am is not None and (am <= 0 or am > 3):
            raise forms.ValidationError("Activity multiplier should be between 0 and 3.")
        return am


class ChangePasswordForm(forms.Form):
    """
    Lets the user change their password (plain-text in your current DB schema).
    """
    current_password = forms.CharField(widget=forms.PasswordInput, label="Current password")
    new_password = forms.CharField(widget=forms.PasswordInput, label="New password", min_length=4)
    confirm_password = forms.CharField(widget=forms.PasswordInput, label="Confirm new password", min_length=4)


    def clean(self):
        data = super().clean()
        new = data.get("new_password")
        confirm = data.get("confirm_password")
        if new and confirm and new != confirm:
            raise forms.ValidationError("New password and confirm password do not match.")
        return data



