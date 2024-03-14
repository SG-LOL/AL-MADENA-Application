# models.py

from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin

from al_madina_app import db, app


class User(db.Model, UserMixin):
    __abstract__ = True
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(30), nullable=False, unique=True)
    password = db.Column(db.String(80), nullable=False)
    phone_number = db.Column(db.String(10))
    is_confirmed = db.Column(db.Boolean, nullable=False, default=False)
    fcm_token = db.Column(db.String(200))


class Citizen(User):
    first_name = db.Column(db.String(30), server_default="1")
    last_name = db.Column(db.String(30))
    date_of_birth = db.Column(db.String(80))


class Admin(User):
    first_name = db.Column(db.String(30), nullable=False)
    last_name = db.Column(db.String(30), nullable=False)
    date_of_birth = db.Column(db.String(80), nullable=False)
    National_ID = db.Column(db.String(30), nullable=False, unique=True)


class Reviewer(User):
    first_name = db.Column(db.String(30), nullable=False)
    last_name = db.Column(db.String(30), nullable=False)
    date_of_birth = db.Column(db.String(80), nullable=False)
    National_ID = db.Column(db.String(30), nullable=False, unique=True)
    is_next = db.Column(db.Boolean, nullable=False, default=False)


class Contractor(User):
    Company_name = db.Column(db.String(30), nullable=False)
    specialty = db.Column(db.String(30), nullable=False)
    contractor_city = db.Column(db.String(30))
    ministry_id = db.Column(db.Integer, db.ForeignKey('ministry.id'))


class Ministry(User):
    ministry_name = db.Column(db.String(30), unique=True)
    ministry_city = db.Column(db.String(30))
    contractors = db.relationship('Contractor', backref='ministry', lazy=True)


class MinistryResponsibility(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    Responsibility = db.Column(db.String(30), nullable=False, )
    ministry_id = db.Column(db.Integer, db.ForeignKey('ministry.id'), nullable=False)
    ministry = db.relationship('Ministry', backref=db.backref('MinistryResponsibility', lazy=True))


class Complaint(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    type = db.Column(db.String(30))
    date = db.Column(db.Date)
    status = db.Column(db.String(30))
    severity = db.Column(db.String(30))
    description = db.Column(db.Text)

    citizen_id = db.Column(db.Integer, db.ForeignKey('citizen.id'))
    citizen = db.relationship('Citizen', backref='complaints', uselist=False)

    reviewer_id = db.Column(db.Integer, db.ForeignKey('reviewer.id'))
    reviewer = db.relationship('Reviewer', backref='complaints', uselist=False)

    ministry_id = db.Column(db.Integer, db.ForeignKey('ministry.id'))
    ministry = db.relationship('Ministry', backref='complaints', uselist=False)

    contractor_id = db.Column(db.Integer, db.ForeignKey('contractor.id'))
    Contractor = db.relationship('Contractor', backref='complaints', uselist=False)

    location_id = db.Column(db.Integer, db.ForeignKey('location.id'))
    location = db.relationship('Location', backref='complaint', uselist=False)

    photos = db.relationship('Photo', backref='complaint', lazy=True, )

    photos = db.relationship('Notification', backref='complaint', lazy=True, )


class Photo(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    complaint_id = db.Column(db.Integer, db.ForeignKey('complaint.id'))
    photo_path = db.Column(db.String(255))


class Location(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    city = db.Column(db.String(50))
    street = db.Column(db.String(50))
    latitude = db.Column(db.DECIMAL(10, 8))
    longitude = db.Column(db.DECIMAL(11, 8))


class Notification(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    body = db.Column(db.String(30))
    title = db.Column(db.String(100))
    is_new = db.Column(db.Boolean, default=True)
    complaint_id = db.Column(db.Integer, db.ForeignKey('complaint.id'))
    citizen_id = db.Column(db.Integer, db.ForeignKey('citizen.id'))
    citizen = db.relationship('Citizen', backref='Notification', uselist=False)


with app.app_context():
    db.create_all()