import 'package:requests/requests.dart';

Future<Map<String, dynamic>> createReviewer(
    String email,
    String fname,
    String lname,
    String phone,
    String dateOfBirth,
    String nationalID,
    String password) async {
  try {
    final response = await Requests.post(
      'http://10.0.2.2:5000/create_reviewer',
      body: {
        'first_name': fname,
        'last_name': lname,
        'date_of_birth': dateOfBirth,
        'National_ID': nationalID,
        'email': email,
        'phone_number': phone,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return {'message': 'succesful'};
    } else {
      return {'message': 'Failed to connect to the server'};
    }
  } catch (error) {
    return {'message': 'Network error'};
  }
}
