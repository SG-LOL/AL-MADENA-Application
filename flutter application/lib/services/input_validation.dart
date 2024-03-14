import 'package:email_validator/email_validator.dart';

String? validateEmail(String email) {
  if (email.isEmpty) {
    return 'please enter an email';
  } else {
    if (!EmailValidator.validate(email)) {
      return 'please inter a vaild email';
    } else {
      return null;
    }
  }
}

String? validatePassword(String password, String confrmPassword) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  if (password.isEmpty || confrmPassword.isEmpty) {
    return 'Please enter a password';
  } else if (password != confrmPassword) {
    return 'Enter valid password';
  } else if (!regex.hasMatch(password)) {
    return 'Enter valid password';
  } else {
    return null;
  }
}
