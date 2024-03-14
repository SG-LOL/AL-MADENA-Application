from functools import wraps

from flask_login import current_user

from al_madina_app import login_manager
from models import *


@login_manager.user_loader
def load_user(user_id):
    citizen = Citizen.query.get(int(user_id))
    if citizen:
        return citizen
    ministry = Ministry.query.get(int(user_id))
    if ministry:
        return ministry
    admin = Admin.query.get(int(user_id))
    if admin:
        return admin
    reviewer = Reviewer.query.get(int(user_id))
    if reviewer:
        return reviewer
    contractor = Contractor.query.get(int(user_id))
    if contractor:
        return contractor
    return None


def login_required_for_user_type(user_type_class):


    def decorator(view_func):
        @wraps(view_func)
        def wrapped_view(*args, **kwargs):
            if not current_user.is_authenticated or not isinstance(current_user, user_type_class):
                return 'wrong user'
            return view_func(*args, **kwargs)

        return wrapped_view

    return decorator
