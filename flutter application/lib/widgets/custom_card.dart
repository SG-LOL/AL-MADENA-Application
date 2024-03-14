import 'package:flutter/material.dart';

Widget _buildComplaintCard(
    BuildContext context, Map<String, dynamic> complaint) {
  double cardWidth = MediaQuery.of(context).size.width - 30;

  return GestureDetector(
    onTap: () {
      print('Complaint ID clicked: ${complaint['complaint_id']}');
    },
    child: Container(
      width: cardWidth,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Complaint ID: ${complaint['complaint_id']}',
              style: TextStyle(color: Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Date: ${complaint['date']}',
              style: TextStyle(color: Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Type: ${complaint['type']}',
              style: TextStyle(color: Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Location: ${complaint['location']['city']}, ${complaint['location']['street']}',
              style: TextStyle(color: Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Description: ${complaint['description']}',
              style: TextStyle(color: Colors.black),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Status: ${complaint['status']}',
              style: TextStyle(color: Colors.red, fontSize: 20),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );
}
