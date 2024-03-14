import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/create_admin_screen/create_admin_screen.dart';
import 'package:majed_s_application2/presentation/create_reviewer_screen/create_reviewer_screen.dart';
import 'package:majed_s_application2/presentation/ministry_application_list/ministry_application_list.dart';
import 'package:majed_s_application2/presentation/welcome_screen/welcome_screen.dart';
import 'package:majed_s_application2/services/user_authentication.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';

// ignore_for_file: must_be_immutable
class AdminScreen extends StatelessWidget {
  AdminScreen({
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
                            text: "Create Admin Account",
                            margin: EdgeInsets.only(left: 32.h, right: 28.h),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAdmin()),
                              );
                            }),
                        SizedBox(height: 26.v),
                        CustomOutlinedButton(
                            text: "Create Reviewer Account",
                            margin: EdgeInsets.only(left: 32.h, right: 28.h),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateReviewer()),
                              );
                            }),
                        SizedBox(height: 26.v),
                        CustomOutlinedButton(
                            text: "Approve Minsitry Application",
                            margin: EdgeInsets.only(left: 32.h, right: 28.h),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MinistryApplicationList()),
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
