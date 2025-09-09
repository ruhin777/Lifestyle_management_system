**Lifestyle Management System**

The Lifestyle Management System is a health-focused web application built with Django and MySQL.  It helps users manage their nutrition, exercise, and health conditions by generating personalized diet and exercise recommendations. Our motivation was to design a system that combines health data, dietary restrictions, and user preferences into a single platform, making it easier for individuals to follow a healthier lifestyle.


**Features:**

1. Welcome Page: Landing page with User Registration and Login.  

2. User Registration & Login: 
   - Sign up with name, email, password, and health details.  
   - Custom `User` table used instead of Django’s default.  
   - Secure login, and session handling. 

3. BMI & BMR Calculation:
   - Calculates BMI and BMR from user data.  
   - Shows BMI category (Underweight, Healthy, Overweight, Obese).  

4. Daily Calorie Intake Suggestion:
   - Uses BMR and activity multiplier.  
   - Displays calories and macronutrient breakdown.  

5. Health Problem Tracking & Restrictions:
   - Search and select health problems.  
   - Displays food and exercise restrictions linked to conditions.  

6. Diet Chart Recommendations: 
   - Personalized meal plan based on calories, restrictions, and preferences.  
   - Stores generated diet plans for reuse.  
   - Option to regenerate a new plan.  

7. Exercise Recommendations:
   - Suggests exercises based on BMI and health problems, filters restricted exercises.
   - Respects user’s saved exercise preferences.  

8. Food’s Nutrition Search:  
   - Search foods by name in the database.  
   - Search exercises by name.  

9. User Preferences: 
    - Add favorite foods and exercises.  
    - Warnings shown if restricted but still allowed to add.  
    - Remove preferences anytime.  

10. Profile Management: 
   - Edit profile details.  
   - Change password.  
   - Remove health problems, meal plans and exercises 

11. Daily Health Tips: 
    - Shows a random tip each day.  
    - Tips vary by BMI category.  


**Database Structure:**

Hybrid approach with Django-managed tables and manually created tables:

Database Setup (Hybrid Managed/Unmanaged Tables):

1. Managed = False (Manually created/imported from SQL dump):
User (custom table, used instead of Django’s default `auth.User`), HealthProblem, FoodNutrition, FoodRestriction, Exercise, ExerciseRestriction, Dietplan, Relation tables: Affects, AppliesTo, Includes, SuffersFrom → These tables were designed in MySQL and can be imported using `lifestyle_management.sql`.

2. Managed = True (Django default migrations):
 FoodPreference and ExercisePreference → These are relationship tables managed by Django for easier usage. 

Note: We replaced the default `auth.User` with our own `User` table for storing application-specific user details (email, age, gender, height, weight, activity level, etc.).


**Project Setup:**

To start this project a user needs to have 3.8+ python, VS code and Xampp(with MariaDB version 10.4.32) installed. After that open the Command Prompt or Windows Powershell and follow the steps below to run the project locally:

1. Clone the Repository:

git clone https://github.com/ruhin777/Lifestyle_management_system.git

cd Lifestyle_management_system

2. Create Virtual Environment

python -m venv venv
venv\Scripts\activate   # On Windows
source venv/bin/activate  # On Mac/Linux

3. Install Dependencies

pip install django==4.1 mysqlclient==2.2.0

4. Import Database

Start Apache and MySQL from the XAMPP Control Panel.


Open http://localhost/phpmyadmin in your browser.


Click on Import from the top menu.


Choose the file lifestyle_management.sql


Click Go.
6. Run migrations 

python manage.py migrate

7. Create superuser (for Django admin only)

python manage.py createsuperuser
8. Run the server

python manage.py runserver

9. Navigate the Application
Open: http://127.0.0.1:8000/
Visit /admin/ → login with superuser to manage data.
Users register/login via the welcome page (custom User table).

Notes:
Database import is mandatory for full feature access
Admins can add new food items, exercises, or health problems through Django Admin (/admin/).
After logging in, users land on the Main Page where they can navigate the features.

Necessary screenshots are attached below:

<img width="1863" height="877" alt="image" src="https://github.com/user-attachments/assets/d5d91688-898a-433c-bf03-f92225129944" />
<img width="1881" height="887" alt="image" src="https://github.com/user-attachments/assets/1bf39423-5335-4ebf-8c44-6ee982bb39e2" />
<img width="1916" height="893" alt="image" src="https://github.com/user-attachments/assets/3c886630-bfe0-4565-89ea-9e29b13420eb" />
<img width="1896" height="903" alt="image" src="https://github.com/user-attachments/assets/20648ce3-10b0-4197-b59f-e6274c753d74" />
<img width="1889" height="903" alt="image" src="https://github.com/user-attachments/assets/38912094-8e8a-473e-8ccd-2d85dd24c3a3" />
<img width="1848" height="663" alt="image" src="https://github.com/user-attachments/assets/ae75e321-5fbc-4e6a-a584-4cc41312bf12" />


