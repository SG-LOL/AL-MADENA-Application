import 'dart:convert';
import 'package:requests/requests.dart';

Future<Map<String, dynamic>?> fetchComplaint(
    String complaintId, String url) async {
  final response = await Requests.get('$url/$complaintId');

  if (response.statusCode == 200) {
    return json.decode(response.body)['complaint'];
  } else {
    print('Failed to fetch complaint. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    return null;
  }
}

Future<List<Map<String, dynamic>>> fetchComplaints(
  List<String> selectedTypes,
  List<String> selectedSeverities,
  List<String> selectedStates,
) async {
  String url = 'http://10.0.2.2:5000/filter_complaints?';

  if (selectedTypes.isNotEmpty) {
    url += 'type=' + Uri.encodeComponent(selectedTypes.join(',')) + '&';
  }

  if (selectedSeverities.isNotEmpty) {
    url +=
        'severity=' + Uri.encodeComponent(selectedSeverities.join(',')) + '&';
  }
  if (selectedStates.isNotEmpty) {
    url += 'status=' + Uri.encodeComponent(selectedStates.join(',')) + '&';
  }

  final response = await Requests.get(url);
  if (response.statusCode == 200) {
    final List<dynamic> complaintsData =
        json.decode(response.body)['user_complaints'];
    return complaintsData.cast<Map<String, dynamic>>();
  } else {
    print('Failed to fetch complaints. Status code: ${response.statusCode}');
    return [];
  }
}

Future<Map<String, dynamic>?> fetchCitizenComplaint(String complaintId) async {
  final complaint = await fetchComplaint(
      complaintId, 'http://10.0.2.2:5000/get_complaint_citizen');
  return complaint;
}

Future<Map<String, dynamic>?> fetchReviewerComplaint(String complaintId) async {
  final complaint = await fetchComplaint(
      complaintId, 'http://10.0.2.2:5000/get_complaint_reviewer');
  return complaint;
}

Future<Map<String, dynamic>?> fetchMinistryComplaint(String complaintId) async {
  final complaint = await fetchComplaint(
      complaintId, 'http://10.0.2.2:5000/get_complaint_ministry');
  return complaint;
}

Future<Map<String, dynamic>?> fetchcontractorComplaint(
    String complaintId) async {
  final complaint = await fetchComplaint(
      complaintId, 'http://10.0.2.2:5000/get_complaint_contractor');
  return complaint;
}

Future<void> updateComplaintStatus(int complaintId, String status) async {
  try {
    final response = await Requests.post(
        'http://10.0.2.2:5000/update_complaint_status/$complaintId',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'status': status});

    if (response.statusCode == 200) {
      print('Complaint updated successfully');
    } else {
      print('Error updating complaint: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> assignContractor(
    int complaintId, int? contractorId, String? severity) async {
  try {
    final response = await Requests.post(
        'http://10.0.2.2:5000/assign_contractor_for_the_complaint/$complaintId',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'contractor_id': contractorId, 'severity': severity});

    if (response.statusCode == 200) {
      print('Complaint updated successfully');
    } else {
      print('Error updating complaint: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> declineComplaint(int complaintId) async {
  try {
    final response = await Requests.post(
        'http://10.0.2.2:5000/decline_complaint/$complaintId');

    if (response.statusCode == 200) {
      print('Complaint updated successfully');
    } else {
      print('Error updating complaint: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
