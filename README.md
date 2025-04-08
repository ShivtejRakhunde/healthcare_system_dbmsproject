# 🏥 Healthcare System

A web-based healthcare management system built with Flask and MySQL to streamline administrative tasks such as patient registration, appointment bookings, staff tracking, and generating activity reports.

---

## 📌 Overview

The **Healthcare System** is designed to help healthcare providers efficiently manage:

- Patient records
- Doctor/staff details
- Appointment scheduling
- Activity logging

This system brings automation and ease-of-use to healthcare operations, improving both administrative workflows and patient experience.

---

## ✨ Features

1. **User Registration & Login**
   - Separate registration for Doctors and Patients
   - Secure login with password hashing

2. **Patient Management**
   - Add, update, delete, and view patient records
   - Store patient details, disease information, and appointment times

3. **Appointment Booking**
   - Book slots with doctors and hospital services
   - View or modify appointments as needed

4. **Staff Management**
   - Register and view hospital doctors by department
   - Search functionality for checking doctor availability

5. **Trigger-Based Reporting**
   - Track and log actions like booking, updating, or deleting patient records
   - View reports for auditing and administrative insights

---

## 🛠 Technologies Used

| Layer       | Technology       |
|-------------|------------------|
| **Frontend**| HTML, CSS, Bootstrap |
| **Backend** | Python Flask     |
| **Database**| MySQL            |

---

## 🚀 Getting Started

### 🔧 Requirements

- Python 3.x
- Flask
- XAMPP (for MySQL)

### 📦 Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/healthcare-system.git
   cd healthcare-system

2. Install Dependencies
```bash
pip install flask flask_sqlalchemy flask_login werkzeug

```

3. Configure MySQL

- Start XAMPP and open phpMyAdmin

- Create a new database: hms

- Import the schema (if you have an SQL file)

- Or let Flask create the tables automatically

4. Update Configuration (if needed)
```bash
app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:your_password@localhost/hms'
```
5. Run the Flask App
```bash
   python app.py
```

### 📂 Folder Structure
```bash
/healthcare-system/
│
├── templates/           # HTML templates
├── static/              # CSS/JS files
├── main.py               # Main Flask application
├── HealthCareSystem.sql     # Sql queries
└── README.md            # Project documentation
```

### 🔐 Security Notes
- Passwords are hashed using werkzeug.security
- Flask-Login is used for session management
- SQLAlchemy ORM is used for most DB operations


## 📸 Screenshots

### 🏠 Home Page
![Home Page](images/Screenshot (150).png)

### 📝 User Login
![User Login](images/Screenshot (152).png)

### 👨‍⚕️ Appointment Booking
![Appointment Booking](images/Screenshot (151).png)
  
