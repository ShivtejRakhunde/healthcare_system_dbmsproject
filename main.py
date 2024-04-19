from flask import Flask,render_template,request,session,redirect,url_for,flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import generate_password_hash,check_password_hash
from flask_login import login_user,logout_user,login_manager,LoginManager
from flask_login import login_required,current_user
from sqlalchemy import text

#my db connection
local_server=True

app = Flask(__name__)
app.secret_key = 'key'

#this is for unique user access
login_manager=LoginManager(app)
login_manager.login_view='login'

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


# app.config['SQLALCHEMY_DATABASE_URL']='mysql://usename:password@localhost/databas_table_name'
app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:@localhost/hms'
db = SQLAlchemy(app)

#here we will create db tables
class Test(db.Model):
    id=db.Column(db.Integer,primary_key=True)
    name=db.Column(db.String(100))
    email=db.Column(db.String(100))

class User(UserMixin,db.Model):
    id=db.Column(db.Integer,primary_key=True)
    username=db.Column(db.String(50))
    email=db.Column(db.String(50),unique=True)
    password=db.Column(db.String(1000))

class Patients(db.Model):
    pid=db.Column(db.Integer,primary_key=True)
    email=db.Column(db.String(50))
    name=db.Column(db.String(50))
    gender=db.Column(db.String(50))
    slot=db.Column(db.String(50))
    disease=db.Column(db.String(50))
    time=db.Column(db.String(50),nullable=False)
    date=db.Column(db.String(50),nullable=False)
    dept=db.Column(db.String(50))
    number=db.Column(db.String(50))

class Doctors(db.Model):
    did=db.Column(db.Integer,primary_key=True)
    email=db.Column(db.String(50))
    dname=db.Column(db.String(50))
    dept=db.Column(db.String(50))

class Trigr(db.Model):
    tid=db.Column(db.Integer,primary_key=True)
    pid=db.Column(db.Integer)
    email=db.Column(db.String(50))
    name=db.Column(db.String(50))
    action=db.Column(db.String(50))
    timestamp=db.Column(db.String(50))
    
#here we will pass endpoints and run the functions
@app.route('/')
def index():
    # a = Test.query.all()
    # print(a)
    return render_template('index.html')
    # return render_template('test.html')

@app.route('/doctor',methods=['POST','GET'])
def doctor():

    if request.method=="POST":

        email=request.form.get('email')
        dname=request.form.get('dname')
        dept=request.form.get('dept')

        query=db.session.execute(text(f"INSERT INTO doctors (email,dname,dept) VALUES ('{email}','{dname}','{dept}')"))
        db.session().commit()
        flash("Information is Stored","primary")

    return render_template('doctor.html')

@app.route('/patient',methods=['POST','GET'])
@login_required
def patient():
    doct=db.session.execute(text("SELECT * FROM `doctors`"))
    print(doct)
    if request.method=="POST":
        email=request.form.get('email')
        name=request.form.get('name')
        gender=request.form.get('gender')
        slot=request.form.get('slot')
        disease=request.form.get('disease')
        time=request.form.get('time')
        date=request.form.get('date')
        dept=request.form.get('dept')
        number=request.form.get('number')
        new_patient = Patients(email=email,name=name,gender=gender,slot=slot,disease=disease,time=time,date=date,dept=dept,number=number)
        db.session.add(new_patient)
        try:
            # Committing the changes to the database
            db.session.commit()
            flash("Booking Confirmed", "info")
        except Exception as e:
            # Rollback the session in case of error
            db.session.rollback()
            flash("An error occurred while booking: {}".format(str(e)), "danger")
    return render_template('patient.html',doct=doct)

@app.route('/details')
@login_required
def details():
    em=current_user.email
    query=db.session.execute(text(f"SELECT * FROM `patients` WHERE email='{em}'"))
    return render_template('details.html',query=query)

@app.route("/edit/<string:pid>",methods=['POST','GET'])
@login_required
def edit(pid):
    post=Patients.query.filter_by(pid=pid).first()
    if request.method=="POST":
        email=request.form.get('email')
        name=request.form.get('name')
        gender=request.form.get('gender')
        slot=request.form.get('slot')
        disease=request.form.get('disease')
        time=request.form.get('time')
        date=request.form.get('date')
        dept=request.form.get('dept')
        number=request.form.get('number')
        db.session.execute(text(f"UPDATE patients SET email = '{email}', name = '{name}', gender = '{gender}', slot = '{slot}', disease = '{disease}', time = '{time}', date = '{date}', dept = '{dept}', number = '{number}' WHERE patients.pid = {pid}"))
        db.session.commit()
        flash("Slot is Updated Successfully","success")
        return redirect('/details')
    return render_template('edit.html',post=post)

@app.route("/delete/<string:pid>",methods=['POST','GET'])
@login_required
def delete(pid):
    db.session.execute(text(f"DELETE FROM patients WHERE patients.pid={pid}"))
    db.session.commit()
    flash("Slot Deleted Successfully","danger")
    return redirect('/details')






@app.route('/signup',methods=['POST','GET'])
def signup():
    if request.method == "POST":
       username=request.form.get('username')
       email=request.form.get('email')
       password=request.form.get('password')
       user=User.query.filter_by(email=email).first()
       #check if email already exists
       if user:
            flash("Email Already Exists","warning")
            return render_template('signup.html')

       encpassword=generate_password_hash(password)
    #    new_user=db.engine.execute(f"INSERT INTO `user` (`username`,`email`,`password`) VALUES ('{username}','{email}','{encpassword}')")
       new_user = User(username=username, email=email, password=encpassword)
       db.session.add(new_user)
       db.session.commit()
       flash("Sign Up Successful Please Login","success")
       return render_template('login.html')
    return render_template('signup.html')

@app.route('/login',methods=['POST','GET'])
def login():
    if request.method == "POST":
       
       email=request.form.get('email')
       password=request.form.get('password')
       print(email,password)
       user=User.query.filter_by(email=email).first()
       if user and check_password_hash(user.password,password):
        login_user(user)
        flash("Login Successful","primary")
        return redirect(url_for('index'))
       else:
        flash("Invalid Credentials","danger")
        return render_template('login.html')


    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash("Successfully Logged Out","warning")
    return redirect(url_for('login'))

@app.route('/test')
def test():
    try:
        Test.query.all()
        return 'Database is connected'
    except:
        return 'Database is not connected'

@app.route('/triggers')
@login_required
def triggers():
    #post=Trigr.query.all()
    post=db.session.execute(text("SELECT * FROM `trigr`"))
    db.session.commit()
    return render_template('triggers.html',post=post)


@app.route('/search',methods=['POST','GET'])
@login_required
def search():
    if request.method == "POST":
        query=request.form.get('search')
        dept=Doctors.query.filter_by(dept=query).first()
        name=Doctors.query.filter_by(dname=query).first()
        if name or dept:
            flash("Doctor is Available","info")
        else:
            flash("Doctor is Not Available","danger")
    return render_template('index.html')

# @app.route('/home')
# def home():
#     return 'This is home page'

app.run(debug=True)

# username=current_user.username