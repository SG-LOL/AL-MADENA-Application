// ignore_for_file: unused_local_variable

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:requests/requests.dart';

class Fcm {
  static Future<void> handleIncomingMessage(RemoteMessage message) async {
    String title = message.notification?.title ?? '';
    String body = message.notification?.body ?? '';
    print("Handling FCM Message: ${message.notification?.title}");
  }

  static void sendTokenToFlask(String token) async {
    final response = await Requests.post(
      'http://10.0.2.2:5000/send-fcm-token',
      body: {'fcm_token': token},
    );

    if (response.statusCode == 200) {
      print('FCM token sent to Flask server successfully');
    } else {
      print(
          'Failed to send FCM token to Flask server. Status code: ${response.statusCode}');
    }
  }

  static void getFcmToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    sendTokenToFlask(fcmToken!);
  }
}
