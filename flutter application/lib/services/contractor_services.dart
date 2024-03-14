import 'dart:convert';

import 'package:requests/requests.dart';

Future<Map<String, dynamic>> fetchContractor(String contractorId) async {
  final response =
      await Requests.get('http://10.0.2.2:5000/get_contractor/$contractorId');

  if (response.statusCode == 200) {
    return json.decode(response.body)['contractor'];
  } else {
    print('Failed to fetch contractor. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to fetch contractor');
  }
}

Future<String> createContractor({
  required String companyName,
  required String phoneNumber,
  required String email,
  required String contractorCity,
  required String password,
  required String specialty,
}) async {
  try {
    final response = await Requests.post(
      'http://10.0.2.2:5000/create_contractor',
      body: {
        'company_name': companyName,
        'phone_number': phoneNumber,
        'email': email,
        'contractor_city': contractorCity,
        'password': password,
        'specialty': specialty,
      },
    );

    if (response.statusCode == 200) {
      return 'successful';
    } else {
      return 'Failed to connect to the server';
    }
  } catch (error) {
    return 'Network error';
  }
}

Future<String?> fetchContractorId() async {
  final response = await Requests.get('http://10.0.2.2:5000/get_contractor_id');

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    return data['contractor_id'].toString();
  } else {
    return null;
  }
}
