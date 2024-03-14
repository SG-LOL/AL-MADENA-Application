import io
import ssl
import uuid
import base64
import secrets
import smtplib
from datetime import datetime, timedelta
from flask_login import login_required, current_user, logout_user, login_user
from PIL import Image
from sqlalchemy import func, and_
from sqlalchemy.orm import joinedload
from al_madina_app import bcrypt, sender_email, password, smtp_server, port
from decorators import login_required_for_user_type, load_user
from models import *
from flask import request, jsonify, session
from firebase_admin import messaging


@app.route('/create_ministry', methods=['POST'])
def create_ministry():
    name = request.form.get('ministry_name')
    phone = request.form.get('phone_number')
    email = request.form.get('email')
    city = request.form.get('city')
    password1 = request.form.get('password')
    hashed_password = bcrypt.generate_password_hash(password1)

    if is_email_used(email):
        return jsonify({'message': 'email is not already in use'})

    ministry = Ministry(

        ministry_name=name,
        email=email,
        password=hashed_password,
        phone_number=phone,
        ministry_city=city

    )

    db.session.add(ministry)
    db.session.commit()
    responsibility_list = request.form.get('responsibility_list')
    result_list = [item.strip() for item in responsibility_list[1:-1].split(',')]

    for item in result_list:
        new_responsibility = MinistryResponsibility(Responsibility=item, ministry_id=ministry.id)
        db.session.add(new_responsibility)

    db.session.commit()

    return jsonify({'message': 'ministry created successfully!'})


@app.route('/create_admin', methods=['POST'])
@login_required_for_user_type(Admin)
def create_admin():
    f_name = request.form.get('first_name')
    l_name = request.form.get('last_name')
    dob = request.form.get('date_of_birth')
    nid = request.form.get('National_ID')
    phone = request.form.get('phone_number')
    email = request.form.get('email')

    password1 = request.form.get('password')
    hashed_password = bcrypt.generate_password_hash(password1)

    admin = Admin(

        first_name=f_name,
        last_name=l_name,
        date_of_birth=dob,
        National_ID=nid,
        email=email,
        password=hashed_password,
        phone_number=phone,

    )

    db.session.add(admin)
    db.session.commit()

    if is_email_used(email):
        return jsonify({'message': 'email is not already in use'})

    return jsonify({'message': 'Admin created successfully!'})


@app.route('/create_reviewer', methods=['POST'])
@login_required_for_user_type(Admin)
def create_reviewer():
    f_name = request.form.get('first_name')
    l_name = request.form.get('last_name')
    dob = request.form.get('date_of_birth')
    nid = request.form.get('National_ID')
    phone = request.form.get('phone_number')
    email = request.form.get('email')

    password1 = request.form.get('password')
    hashed_password = bcrypt.generate_password_hash(password1)

    if is_email_used(email):
        return jsonify({'message': 'email is not already in use'})

    reviewer = Reviewer(

        first_name=f_name,
        last_name=l_name,
        date_of_birth=dob,
        National_ID=nid,
        email=email,
        password=hashed_password,
        phone_number=phone,

    )

    db.session.add(reviewer)
    db.session.commit()

    return jsonify({'message': 'Admin created successfully!'})


@app.route('/create_contractor', methods=['POST'])
@login_required_for_user_type(Ministry)
def create_contractor():
    name = request.form.get('company_name')
    phone = request.form.get('phone_number')
    email = request.form.get('email')
    city = request.form.get('contractor_city')
    password1 = request.form.get('password')
    specialty = request.form.get('specialty')
    hashed_password = bcrypt.generate_password_hash(password1)

    if is_email_used(email):
        return jsonify({'message': 'email is not already in use'})

    contractor = Contractor(
        Company_name=name,
        email=email,
        password=hashed_password,
        phone_number=phone,
        contractor_city=city,
        specialty=specialty,
        ministry_id=current_user.id,

    )
    db.session.add(contractor)
    db.session.commit()

    return jsonify({'message': 'contractor created successfully!'})


@app.route('/unconfirmed_ministries', methods=['GET'])
@login_required_for_user_type(Admin)
def get_unconfirmed_ministries():
    unconfirmed_ministries = Ministry.query.filter_by(is_confirmed=False).all()
    if not unconfirmed_ministries:
        return jsonify({"message": "No unconfirmed ministries found for the user"})

    ministries = []

    for ministry in unconfirmed_ministries:
        res_list = []
        respo = MinistryResponsibility.query.filter_by(ministry_id=ministry.id).all()

        for res in respo:
            res_list.append(res.Responsibility)

        unconfirmed_ministries_info = {
            'id': ministry.id,
            'ministry_name': ministry.ministry_name,
            'phone_number': ministry.phone_number,
            'email': ministry.email,
            'city': ministry.ministry_city,
            'resp': res_list,
            'hmm': {'hmm': 'hmm'}
        }
        ministries.append(unconfirmed_ministries_info)

    return jsonify({'unconfirmed_ministries_info': ministries})


@app.route('/get_ministry/<ministry_id>', methods=['GET'])
@login_required_for_user_type(Admin or Ministry)
def get_ministry(ministry_id):
    ministry = Ministry.query.get(ministry_id)

    if ministry is None:
        return jsonify({'error': 'Ministry not found'})

    res_list = [res.Responsibility for res in MinistryResponsibility.query.filter_by(ministry_id=ministry.id).all()]

    ministry_info = {
        'id': ministry.id,
        'ministry_name': ministry.ministry_name,
        'phone_number': ministry.phone_number,
        'email': ministry.email,
        'city': ministry.ministry_city,
        'resp': res_list,
        'visible': 'true'
    }

    return jsonify({'ministry': ministry_info})


@app.route('/get_contractor/<contractor_id>', methods=['GET'])
@login_required_for_user_type(Ministry or Contractor)
def get_contractor(contractor_id):
    contractor = Contractor.query.get(contractor_id)

    if contractor is None:
        return jsonify({'error': 'Contractor not found'})

    contractor_info = {
        'id': contractor.id,
        'company_name': contractor.Company_name,
        'phone_number': contractor.phone_number,
        'email': contractor.email,
        'city': contractor.contractor_city,
        'specialty': contractor.specialty,
        'visible': 'true'
    }

    return jsonify({'contractor': contractor_info})


@app.route('/confirm_ministry/<ministry_id>', methods=['GET'])
@login_required_for_user_type(Admin)
def confirm_ministry(ministry_id):
    ministry = Ministry.query.get(ministry_id)

    if ministry:
        ministry.is_confirmed = 1
        db.session.commit()
        return jsonify({'message': 'Ministry account is confirmed'})
    else:
        return jsonify({'message': 'Ministry account is not confirmed'})


@app.route('/send_decline_email', methods=['POST'])
@login_required_for_user_type(Admin)
def send_decline_email():
    email = request.form.get('email')
    text = 'your application was denied '
    send_email(email, text)
    return jsonify({'message': 'Email sent successfully!'})


@app.route('/register', methods=['POST'])
def register():
    email = request.form.get('email')
    password2 = request.form.get('password')
    hashed_password = bcrypt.generate_password_hash(password2)

    does_it_exist = is_email_used(email)
    if does_it_exist:
        return jsonify({'message': 'Email already exists. Please use a different email.'})
    else:
        citizen = Citizen(email=email, password=hashed_password)
        db.session.add(citizen)
        db.session.commit()
        if citizen and bcrypt.check_password_hash(citizen.password, password2):
            login_user(citizen)
        return jsonify({'message': 'Thank you for registering!'})


@app.route('/send_email', methods=['POST'])
@login_required
def email_info():
    session['verification_code'] = secrets.randbelow(10 ** 5)
    verification_code = session.get('verification_code')
    email = current_user.email
    text = 'your verification code is '

    message = f'{text} {verification_code}'

    send_email(email, message)

    return jsonify({'message': 'Email verification successful!'})


@login_required
def send_email(email, message):
    context = ssl.create_default_context()

    try:
        server = smtplib.SMTP(smtp_server, port)
        server.ehlo()
        server.starttls(context=context)
        server.login(sender_email, password)
        server.sendmail(sender_email, email, message)
    finally:
        server.quit()


@app.route('/verify', methods=['POST'])
@login_required
def verify():
    verification_code = request.form.get('verification_code')
    stored_verification_code = session.get('verification_code')
    if verification_code == str(stored_verification_code):
        current_user.is_confirmed = True
        db.session.commit()
        return jsonify({'message': 'Email verification successful!'})
    else:
        return jsonify({'message': 'Invalid verification code.'})


@app.route('/login', methods=['POST'])
def login():
    email = request.form.get('email')
    password1 = request.form.get('password')

    user = is_email_used(email)

    if user and bcrypt.check_password_hash(user.password, password1):
        login_user(user)

        class_name = user.__class__.__name__

        if class_name == 'Citizen':

            if user.is_confirmed:
                if user.first_name is None:
                    return jsonify({'message': 'incomplete profile information'})
                else:
                    return jsonify({'message': 'complete profile information'})
            else:
                return jsonify({'message': 'account is not verified'})

        elif class_name == 'Admin':
            if user.is_confirmed:
                return jsonify({'message': 'admin login'})
            else:
                return jsonify({'message': 'change password'})
        elif class_name == 'Reviewer':
            if user.is_confirmed:
                return jsonify({'message': 'reviewer login'})
            else:
                return jsonify({'message': 'change password'})
        elif class_name == 'Ministry':
            if user.is_confirmed:
                return jsonify({'message': 'ministry login'})
            else:
                return jsonify({'message': 'waiting for confirmation'})
        elif class_name == 'Contractor':
            if user.is_confirmed:
                return jsonify({'message': 'contactor login'})
            else:
                return jsonify({'message': 'change password'})

    return jsonify({'message': 'incorrect password or email'})


@app.route('/logout', methods=['GET'])
@login_required
def logout():
    logout_user()
    return jsonify({'message': 'Logged out successfully'})


@app.route('/complete_profile', methods=['post'])
@login_required
def update_info():
    if not User:
        return jsonify({'message': 'Citizen not found'})

    current_user.first_name = request.form.get('first_name')
    current_user.last_name = request.form.get('last_name')
    current_user.date_of_birth = request.form.get('date_of_birth')
    current_user.phone_number = request.form.get('phone_number')

    db.session.commit()

    return jsonify({'message': 'Citizen information updated successfully'})


@app.route('/update_password', methods=['POST'])
@login_required
def update_password():
    current_password = request.form.get('current_password')
    new_password = request.form.get('new_password')
    if bcrypt.check_password_hash(current_user.password, current_password):
        hashed_new_password = bcrypt.generate_password_hash(new_password)
        current_user.password = hashed_new_password
        current_user.is_confirmed = 1
        db.session.commit()

        return jsonify({'message': 'Password updated successfully'})
    else:
        return jsonify({'message': 'Current password is incorrect'})


@app.route('/citizen_info', methods=['GET'])
@login_required
def citizen_info():
    citizen_info = {
        'id': current_user.id,
        'email': current_user.email,
        'phone_number': current_user.phone_number,
        'first_name': current_user.first_name,
        'last_name': current_user.last_name,
        'date_of_birth': current_user.date_of_birth,
    }

    return jsonify(citizen_info)


@app.route('/get_ministry_id', methods=['GET'])
@login_required
def ministry_id():
    ministry_id = current_user.id
    return jsonify(({'ministry_id': ministry_id}))


@app.route('/get_contractor_id', methods=['GET'])
@login_required
def contractor_id():
    contractor_id = current_user.id
    return jsonify(({'contractor_id': contractor_id}))


@app.route('/submit_complaint', methods=['POST'])
@login_required_for_user_type(Citizen)
def submit_complaint():
    if not current_user.is_confirmed:
        return "Only confirmed users can submit complaints."

    complaint_data = request.json

    city = complaint_data.get('city')
    street = complaint_data.get('street')
    latitude = complaint_data.get('latitude')
    longitude = complaint_data.get('longitude')

    new_location = Location(city=city, street=street, latitude=latitude, longitude=longitude)
    db.session.add(new_location)
    db.session.commit()

    type = complaint_data.get('type')
    complaint_date = datetime.now().strftime('%Y-%m-%d')
    parsed_date = datetime.strptime(complaint_date, '%Y-%m-%d').date()
    description = complaint_data.get('description')

    reviewer = Reviewer.query.filter_by(is_active=1).first()
    if not reviewer:
        reviewer = Reviewer.query.first()

    complaint = Complaint(type=type, date=parsed_date, description=description,
                          location_id=new_location.id, citizen_id=current_user.id, status='Received',
                          reviewer_id=reviewer.id)

    db.session.add(complaint)
    db.session.commit()

    next_reviewer = Reviewer.query.filter_by(is_active=0).first()
    if not next_reviewer:
        next_reviewer = Reviewer.query.first()

    next_reviewer.is_next = 1
    reviewer.is_next = 0

    base64_images = complaint_data.get('images')

    if base64_images:
        for base64_image in base64_images:
            image_bytes = base64.b64decode(base64_image)
            image_format = Image.open(io.BytesIO(image_bytes)).format.lower()
            file_path = f'photos/{uuid.uuid4()}.{image_format}'

            with open(file_path, 'wb') as f:
                f.write(image_bytes)

            new_photo = Photo(photo_path=file_path, complaint_id=complaint.id)
            db.session.add(new_photo)

        db.session.commit()

    return "Complaint successfully submitted."


@app.route('/user_complaints', methods=['GET'])
@login_required
def user_complaints():
    if not current_user.is_authenticated:
        return "User not authenticated"
    user = load_user(current_user.id)
    class_name = user.__class__.__name__
    column_name = f"{class_name.lower()}_id"

    complaints = Complaint.query.filter_by(**{column_name: current_user.id}).all()

    if not complaints:
        return "No complaints found for the user"

    user_complaints_list = []
    for complaint in reversed(complaints):
        location = Location.query.get(complaint.location_id)

        complaint_info = {
            'complaint_id': complaint.id,
            'type': complaint.type,
            'date': complaint.date,
            'status': complaint.status,
            'severity': complaint.severity,
            'description': complaint.description,
            'location': {
                'city': location.city,
                'street': location.street,
            },
        }

        user_complaints_list.append(complaint_info)

    return jsonify({'user_complaints': user_complaints_list})


@app.route('/filter_complaints', methods=['GET'])
def filter_complaints():
    if not current_user.is_authenticated:
        return "User not authenticated"

    user = load_user(current_user.id)

    class_name = user.__class__.__name__
    column_name = f"{class_name.lower()}_id"

    severity = request.args.get('severity')
    complaint_type = request.args.get('type')
    complaint_statue = request.args.get('status')
    complaint_status_list = [type.strip() for type in complaint_statue.split(',')] if complaint_statue else []
    complaint_type_list = [type.strip() for type in complaint_type.split(',')] if complaint_type else []
    severity_list = [sev.strip() for sev in severity.split(',')] if severity else []

    query = Complaint.query.filter(
        and_(
            (Complaint.severity.in_(severity_list) if severity_list else True),
            (Complaint.type.in_(complaint_type_list) if complaint_type_list else True),
            (Complaint.status.in_(complaint_status_list) if complaint_status_list else True),
            (getattr(Complaint, column_name) == current_user.id)
        )
    )
    filtered_complaints = query.all()

    complaints_list = []

    for complaint in reversed(filtered_complaints):
        location = Location.query.get(complaint.location_id)

        complaint_info = {
            'complaint_id': complaint.id,
            'type': complaint.type,
            'date': complaint.date,
            'status': complaint.status,
            'severity': complaint.severity,
            'description': complaint.description,
            'location': {
                'city': location.city,
                'street': location.street,
            },
        }

        complaints_list.append(complaint_info)

    return jsonify({'user_complaints': complaints_list})


@app.route('/get_complaint_citizen/<int:complaint_id>', methods=['GET'])
@login_required_for_user_type(Citizen)
def get_complaint_citizen(complaint_id):
    complaint_info = get_complaint(complaint_id)
    complaint_date = complaint_info['date']
    today_date = datetime.now().date()

    if today_date == complaint_date:
        complaint_info['visible'] = 'true'

    return jsonify({'complaint': complaint_info})


@app.route('/get_complaint_reviewer/<int:complaint_id>', methods=['GET'])
@login_required_for_user_type(Reviewer)
def get_complaint_reviewer(complaint_id):
    complaint_info = get_complaint(complaint_id)
    complaint_type = complaint_info['type']
    complaint_date = complaint_info['date']
    complaint_status = complaint_info['status']
    location_city = complaint_info['location']['city']
    today_date = datetime.now().date()
    complaint_info['list'] = get_ministry_list(location_city, complaint_type)
    if complaint_status.lower() == 'received' and today_date != complaint_date:
        complaint_info['visible'] = 'true'

    return jsonify({'complaint': complaint_info})


@app.route('/get_complaint_ministry/<int:complaint_id>', methods=['GET'])
@login_required_for_user_type(Ministry)
def get_complaint_ministry(complaint_id):
    complaint_info = get_complaint(complaint_id)
    complaint_type = complaint_info['type']
    complaint_status = complaint_info['status']
    complaint_info['list'] = get_contractor_list(complaint_type)
    if complaint_status == 'Transferred to Authorities':
        complaint_info['visible'] = 'true'

    return jsonify({'complaint': complaint_info})


@app.route('/get_complaint_contractor/<int:complaint_id>', methods=['GET'])
@login_required_for_user_type(Contractor)
def get_complaint_contractor(complaint_id):
    complaint_info = get_complaint(complaint_id)
    complaint_info['visible'] = 'true'
    return jsonify({'complaint': complaint_info})


def get_complaint(complaint_id):
    user = load_user(current_user.id)
    class_name = user.__class__.__name__
    column_name = f"{class_name.lower()}_id"
    if not current_user.is_authenticated:
        return "User not authenticated"

    complaint = Complaint.query.get(complaint_id)

    if not complaint or getattr(complaint, column_name) != current_user.id:
        return "Complaint not found or unauthorized access"

    location = Location.query.get(complaint.location_id)
    photos = Photo.query.filter_by(complaint_id=complaint.id).all()

    encoded_photos = []
    for photo in photos:
        with open(photo.photo_path, 'rb') as file:
            encoded_photo = base64.b64encode(file.read()).decode('utf-8')
            encoded_photos.append(encoded_photo)

    complaint_info = {
        'complaint_id': complaint.id,
        'type': complaint.type,
        'date': complaint.date,
        'status': complaint.status,
        'severity': complaint.severity,
        'description': complaint.description,
        'visible': 'false',
        'location': {
            'city': location.city,
            'street': location.street,
            'latitude':location.latitude,
            'longitude':location.longitude,
        },
        'photos': encoded_photos,
    }
    return complaint_info

@app.route('/update_complaint', methods=['POST'])
def update_complaint():
    data = request.json

    # Extract data from the request
    complaint_id = data.get('id')
    images = data.get('images')
    complaint_type = data.get('type')
    description = data.get('description')
    city = data.get('city')
    street = data.get('street')
    latitude = data.get('latitude')
    longitude = data.get('longitude')
    complaint = Complaint.query.filter_by(id=complaint_id).first()
    if complaint:

        complaint.images = images
        complaint.type = complaint_type
        complaint.description = description
        complaint.city = city
        complaint.street = street
        complaint.latitude = latitude
        complaint.longitude = longitude

        db.session.commit()

        return jsonify({'message': 'Complaint updated successfully'})
    else:
        return jsonify({'error': 'Complaint not found'})


def get_ministry_list(location_city, complaint_type):
    ministries_id = []

    ministries = Ministry.query.filter(
        func.lower(Ministry.ministry_city) == func.lower(location_city),
        MinistryResponsibility.Responsibility == complaint_type, Ministry.id == MinistryResponsibility.ministry_id
    ).options(joinedload(Ministry.MinistryResponsibility)).all()

    ministry_list = ['choose a ministry']
    for ministry in ministries:
        ministries_id.append(ministry.id)
        ministry_info = f"{ministry.id}, {ministry.ministry_name}, {ministry.ministry_city}"
        ministry_list.append(ministry_info)

    remaining_ministries = Ministry.query.filter(~Ministry.id.in_(ministries_id)).all()
    for ministry in remaining_ministries:
        ministry_info = f"{ministry.id}, {ministry.ministry_name}, {ministry.ministry_city}"
        ministry_list.append(ministry_info)
    return ministry_list


def get_contractor_list(complaint_type):
    contractor_id = []

    contractors = Contractor.query.filter(
        and_(Contractor.specialty == complaint_type, Ministry.id == Contractor.ministry_id)
    ).all()

    contractor_list = ['choose a contractor']
    for contractor in contractors:
        contractor_id.append(contractor.id)
        ministry_info = f"{contractor.id}, {contractor.Company_name}, {contractor.contractor_city}"
        contractor_list.append(ministry_info)

    return contractor_list


@app.route('/assign_ministry_for_the_complaint/<int:complaint_id>', methods=['POST'])
@login_required_for_user_type(Reviewer)
def assign_ministry_for_the_complaint(complaint_id):
    complaint_to_update = Complaint.query.get(complaint_id)
    ministry_id = request.form.get('ministry_id')
    severity = request.form.get('severity')
    if ministry_id == '-1' or severity == 'select severity level':
        return jsonify({'error': 'incomplete data'})

    if complaint_to_update:
        complaint_to_update.ministry_id = ministry_id
        complaint_to_update.status = 'Transferred to Authorities'
        complaint_to_update.severity = severity
        db.session.commit()
        create_notification(complaint_id)

        return jsonify({'message': 'Complaint updated successfully'})
    else:
        return jsonify({'error': 'Complaint not found'})


@app.route('/assign_contractor_for_the_complaint/<int:complaint_id>', methods=['POST'])
@login_required_for_user_type(Ministry)
def assign_contractor_for_the_complaint(complaint_id):
    complaint_to_update = Complaint.query.get(complaint_id)
    contractor_id = request.form.get('contractor_id')
    severity = request.form.get('severity')
    if contractor_id == '-1' or severity == 'select severity level':
        return jsonify({'error': 'incomplete data'})

    if complaint_to_update:
        complaint_to_update.contractor_id = contractor_id
        complaint_to_update.status = 'Assigned to Contractor'
        complaint_to_update.severity = severity
        db.session.commit()
        create_notification(complaint_id)

        return jsonify({'message': 'Complaint updated successfully'})
    else:
        return jsonify({'error': 'Complaint not found'})


@app.route('/update_complaint_status/<int:complaint_id>', methods=['POST'])
@login_required_for_user_type(Contractor)
def update_complaint_status(complaint_id):
    complaint_to_update = Complaint.query.get(complaint_id)
    status = request.form.get('status')

    if complaint_to_update:
        complaint_to_update.status = status
        db.session.commit()

        create_notification(complaint_id)

        return jsonify({'message': 'Complaint updated successfully'})
    else:
        return jsonify({'error': 'Complaint not found'})


@app.route('/decline_complaint/<int:complaint_id>', methods=['POST'])
@login_required_for_user_type(Reviewer or Ministry)
def decline_complaint(complaint_id):
    complaint_to_update = Complaint.query.get(complaint_id)

    if complaint_to_update:
        complaint_to_update.status = 'declined'
        db.session.commit()

        return jsonify({'message': 'Complaint updated successfully'})
    else:
        return jsonify({'error': 'Complaint not found'})


def create_notification(complaint_id):
    complaint = Complaint.query.get(complaint_id)
    citizen = Citizen.query.get(complaint.citizen_id)
    fcm_token = citizen.fcm_token

    title = f"Complaint {complaint_id} Update"
    body = f"The status of your complaint has been updated to {complaint.status}."

    success = send_fcm_notification(fcm_token, title, body)
    if success:

        notification = Notification(
            body=body,
            title=title,
            citizen_id=citizen.id,
            complaint_id=complaint_id,
        )

        db.session.add(notification)
        db.session.commit()
        return jsonify({"status": "success", "message": "FCM token received and notification sent"})
    else:
        return jsonify({"status": "error", "message": "Failed to send FCM notification"})


@app.route('/get_notification', methods=['GET'])
def get_notification():
    user = load_user(current_user.id)
    user_notifications = Notification.query.filter_by(citizen_id=user.id).all()

    notification_list = []

    for user_notification in reversed(user_notifications):
        notification_info = {
            'id': user_notification.id,
            'Title': user_notification.title,
            'Body': user_notification.body,
            'is_new': user_notification.is_new,
            'complaint_id': user_notification.complaint_id
        }

        notification_list.append(notification_info)

    return jsonify({'notification_info': notification_list})


@app.route('/mark_notification_as_read/<int:notification_id>', methods=['PUT'])
def mark_notification_as_read(notification_id):
    notification = Notification.query.filter_by(id=notification_id).first()
    if notification:
        notification.is_new = False
        db.session.commit()
        return jsonify({'message': 'Notification marked as read successfully'})
    else:
        return jsonify({'error': 'Notification not found'})


def send_fcm_notification(token, title, body):
    message = messaging.Message(
        notification=messaging.Notification(
            title=title,
            body=body,
        ),
        token=token,
    )

    try:
        messaging.send(message)
        return True
    except Exception as e:
        print('Failed to send message:', e)
        return False


@app.route('/send-fcm-token', methods=['POST'])
def receive_fcm_token():
    fcm_token = request.form.get('fcm_token')
    current_user.fcm_token = fcm_token
    db.session.commit()

    return jsonify({"status": "fcm token has been received"})


@app.route('/delete_complaint/<int:complaint_id>', methods=['DELETE'])
@login_required_for_user_type(Citizen)
def delete_complaint(complaint_id):
    if not current_user.is_authenticated:
        return "User not authenticated"

    complaint = Complaint.query.get(complaint_id)

    if not complaint or complaint.citizen_id != current_user.id:
        return "Complaint not found or unauthorized access",

    db.session.delete(complaint)
    db.session.commit()

    return jsonify({"message": "Complaint deleted successfully"})


def is_email_used(email):
    citizen = Citizen.query.filter_by(email=email).first()
    if citizen:
        return citizen
    ministry = Ministry.query.filter_by(email=email).first()
    if ministry:
        return ministry
    admin = Admin.query.filter_by(email=email).first()
    if admin:
        return admin
    reviewer = Reviewer.query.filter_by(email=email).first()
    if reviewer:
        return reviewer
    contractor = Contractor.query.filter_by(email=email).first()
    if contractor:
        return contractor
    return None


if __name__ == '__main__':
    app.run(debug=True)
