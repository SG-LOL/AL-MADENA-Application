import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager
import firebase_admin
from firebase_admin import credentials

db = SQLAlchemy()
app = Flask(__name__)
bcrypt = Bcrypt(app)
login_manager = LoginManager(app)
login_manager.init_app(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
app.config['SECRET_KEY'] = 'SECRET_KEY'
db.init_app(app)
photos_directory = os.path.join(app.root_path, 'photos')
os.makedirs(photos_directory, exist_ok=True)
smtp_server = "smtp.gmail.com"
port = 587
sender_email = "email address"
password = "password"
cred = credentials.Certificate('credentials.json')
firebase_admin.initialize_app(cred)



