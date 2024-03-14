import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/profile_screen/profile_screen.dart';
import 'package:majed_s_application2/presentation/reviewer_complaint_list_screen/reviewer_complaint_list_screen.dart';
import 'package:majed_s_application2/presentation/welcome_screen/welcome_screen.dart';
import 'package:majed_s_application2/services/user_authentication.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';

// ignore_for_file: must_be_immutable
class ReviewerScreen extends StatelessWidget {
  ReviewerScreen({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 250.v),
                        SizedBox(height: 26.v),
                        CustomOutlinedButton(
                            text: "view Complaints",
                            margin: EdgeInsets.only(left: 32.h, right: 28.h),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ReviewerComplaintListScreen()),
                              );
                            }),
                        SizedBox(height: 26.v),
                        CustomOutlinedButton(
                            text: "Profile Information",
                            margin: EdgeInsets.only(left: 32.h, right: 28.h),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen()),
                              );
                            }),
                        SizedBox(height: 26.v),
                        CustomOutlinedButton(
                            text: "Sign Out",
                            margin: EdgeInsets.only(left: 32.h, right: 28.h),
                            onPressed: () {
                              logout();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomeScreen()),
                              );
                            }),
                        Spacer(flex: 62)
                      ]),
                ))));
  }
}
