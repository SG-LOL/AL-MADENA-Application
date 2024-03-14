import 'dart:convert';

import 'package:requests/requests.dart';

Future<List<dynamic>> fetchUnconfirmedMinistriesData() async {
  try {
    final response =
        await Requests.get('http://10.0.2.2:5000/unconfirmed_ministries');
    if (response.statusCode == 200) {
      return json.decode(response.body)['unconfirmed_ministries_info'];
    } else {
      throw Exception(
          'Failed to fetch data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception: $e');
    throw e;
  }
}

Future<Map<String, dynamic>> createMinistry(
    String email,
    String ministryName,
    String phoneNumber,
    String city,
    String password,
    List<String> responsibilityList) async {
  try {
    final response =
        await Requests.post('http://10.0.2.2:5000/create_ministry', body: {
      'ministry_name': ministryName,
      'phone_number': phoneNumber,
      'email': email,
      'city': city,
      'password': password,
      'responsibility_list': responsibilityList,
    });

    if (response.statusCode == 200) {
      return {'message': 'succesful'};
    } else {
      return {'message': 'Failed to connect to the server'};
    }
  } catch (error) {
    return {'message': 'Network error'};
  }
}

Future<Map<String, dynamic>> fetchMinistry(String ministryId) async {
  final response =
      await Requests.get('http://10.0.2.2:5000/get_ministry/$ministryId');

  if (response.statusCode == 200) {
    return json.decode(response.body)['ministry'];
  } else {
    print('Failed to fetch Ministry. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
  throw Exception('Failed to fetch ministry');
}

Future<String?> getMinistryId() async {
  final response = await Requests.get('http://10.0.2.2:5000/get_ministry_id');

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['ministry_id'].toString();
  } else {
    return null;
  }
}
