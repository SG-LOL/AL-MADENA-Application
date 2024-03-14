import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:majed_s_application2/presentation/change_password_screen/change_password_screen.dart';
import 'package:majed_s_application2/presentation/complaint_list_screen/complaint_list_screen.dart';
import 'package:majed_s_application2/presentation/notification_screen/notification_screen.dart';
import 'package:majed_s_application2/presentation/profile_screen/profile_screen.dart';
import 'package:majed_s_application2/presentation/type_screen/type_screen.dart';
import 'package:majed_s_application2/presentation/welcome_screen/welcome_screen.dart';
import 'package:majed_s_application2/services/user_authentication.dart';
import 'package:requests/requests.dart';

class Navebar extends StatefulWidget {
  const Navebar({Key? key}) : super(key: key);

  @override
  _NavebarState createState() => _NavebarState();
}

class _NavebarState extends State<Navebar> {
  String fullName = '';
  String email = '';

  Future<void> fetchUserInfo() async {
    try {
      final response = await Requests.get('http://10.0.2.2:5000/citizen_info');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        String fName = data['first_name'];
        String lName = data['last_name'];
        setState(() {
          fullName = '$fName $lName';
          email = data['email'];
        });
      } else {
        // Handle error, e.g., show an error message
        print('Failed to load user information');
      }
    } catch (e) {
      // Handle exception
      print('Exception: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserInfo(); // Fetch user info when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        UserAccountsDrawerHeader(
          accountName: Text(fullName), // Display full name here
          accountEmail: Text(email),
          decoration: BoxDecoration(color: Color.fromARGB(255, 101, 170, 238)),
        ),
        ListTile(
          leading: Icon(Icons.account_circle_outlined),
          trailing: Icon(Icons.arrow_forward_ios_outlined),
          title: Text("Profile"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.assignment_turned_in_outlined),
          trailing: Icon(Icons.arrow_forward_ios_outlined),
          title: Text("Previous Complaint"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ComplaintListScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.assignment_outlined),
          trailing: Icon(Icons.arrow_forward_ios_outlined),
          title: Text("Submit A Complaint"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TypeScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.password_outlined),
          trailing: Icon(Icons.arrow_forward_ios_outlined),
          title: Text("Change Password"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.language_outlined),
          trailing: Icon(Icons.arrow_forward_ios_outlined),
          title: Text("Notifications"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          trailing: Icon(Icons.arrow_forward_ios_outlined),
          title: Text("Sign Out"),
          onTap: () {
            logout();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          },
        ),
      ]),
    );
  }
}
