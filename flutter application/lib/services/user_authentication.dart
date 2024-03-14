import 'dart:convert';

import 'package:requests/requests.dart';

Future<void> register(String email, String password) async {
  try {
    final response = await Requests.post(
      'http://10.0.2.2:5000/register',
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      print(json.decode(response.body)['message']);
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Exception: $e');
  }
}

Future<void> updatePassword(String currentPassword, String newPassword) async {
  try {
    final response = await Requests.post(
      'http://10.0.2.2:5000/update_password',
      body: {
        'current_password': currentPassword,
        'new_password': newPassword,
      },
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body)['message']);
    } else {
      print('Failed to update password: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Exception: $e');
  }
}

Future<Map<String, dynamic>> loginUser(String email, String password) async {
  try {
    final response = await Requests.post(
      'http://10.0.2.2:5000/login',
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      print('Error: ${response.statusCode}');
      return {'message': 'Failed to connect to the server'};
    }
  } catch (error) {
    print('Error: $error');
    return {'message': 'Network error'};
  }
}

Future<bool> sendVerificationEmail() async {
  try {
    final response = await Requests.post('http://10.0.2.2:5000/send_email');

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<bool> sendVerificationCode(String verificationCode) async {
  try {
    final response = await Requests.post(
      'http://10.0.2.2:5000/verify',
      body: {'verification_code': verificationCode},
    );

    if (response.statusCode == 200) {
      print('Email verification successful!');
      return true;
    } else {
      print('Invalid verification code.');
      return false;
    }
  } catch (e) {
    print('Error sending verification code: $e');
    return false;
  }
}

Future<void> logout() async {
  try {
    final response = await Requests.get('http://10.0.2.2:5000/logout');

    if (response.statusCode == 200) {
      // Logout successful, handle as needed
      print('Logout successful');
    } else {
      // Logout failed, handle as needed
      print('Logout failed: ${response.reasonPhrase}');
    }
  } catch (e) {
    // Handle exception
    print('Exception: $e');
  }
}
