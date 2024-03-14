import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/complaint_listone_screen/complaint_listone_screen.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/navbar.dart';
import 'package:requests/requests.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key})
      : super(
          key: key,
        );
  @override
  _NotificationScreen createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  Future<List<dynamic>> getNotifications() async {
    try {
      final response =
          await Requests.get('http://10.0.2.2:5000/get_notification');
      if (response.statusCode == 200) {
        return json.decode(response.body)['notification_info'];
      } else {
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
      throw e;
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      final response = await Requests.put(
        'http://10.0.2.2:5000/mark_notification_as_read/$notificationId',
      );
      if (response.statusCode == 200) {
        print('Notification marked as read successfully');
      } else {
        throw Exception(
            'Failed to mark notification as read. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error marking notification as read: $e');
      throw e;
    }
  }

  TextEditingController searchController = TextEditingController();

  late List<Map<String, dynamic>> notifications = [];

  Future<void> updateNotification() async {
    try {
      List<dynamic> data = await getNotifications();
      setState(() {
        notifications = data.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      print('Error updating Notifications state: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    notifications = [];
    updateNotification();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        endDrawer: Navebar(),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 14.h),
                  child: Text(
                    "Notification ",
                    style: CustomTextStyles.titleLargeMontserratGray80002,
                  ),
                ),
                SizedBox(height: 13.v),
                Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildNotificationCard(
                        context, notifications[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
      BuildContext context, Map<String, dynamic> notification) {
    double cardWidth = MediaQuery.of(context).size.width - 30;

    bool isNew = notification['is_new'];

    return GestureDetector(
      onTap: () {
        markNotificationAsRead(notification['id'].toString());
        final String complaintId = '${notification['complaint_id']}';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComplaintListoneScreen(
              complaintId: complaintId,
            ),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' ${notification['Title']}',
                    style: TextStyle(color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${notification['Body']}',
                    style: TextStyle(color: Colors.black),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (isNew) // Show the badge only if the notification is new
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'New',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 30.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 6.h, top: 16.v, bottom: 15.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      title: AppbarSubtitle(text: "Back", margin: EdgeInsets.only(left: 5.h)),
    );
  }

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
