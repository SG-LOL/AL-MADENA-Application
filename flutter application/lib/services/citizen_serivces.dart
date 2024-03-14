import 'dart:convert';

import 'package:requests/requests.dart';

Future<bool> completeProfile({
  required String firstName,
  required String phoneNumber,
  required String lastName,
  required String dateOfBirth,
}) async {
  try {
    final response = await Requests.post(
      'http://10.0.2.2:5000/complete_profile',
      body: {
        'first_name': firstName,
        'phone_number': phoneNumber,
        'last_name': lastName,
        'date_of_birth': dateOfBirth,
      },
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body)['message']);
      return true;
    } else {
      print('Error: ${response.reasonPhrase}');
      return false;
    }
  } catch (e) {
    print('Exception: $e');
    return false;
  }
}
