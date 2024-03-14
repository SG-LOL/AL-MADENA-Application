import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/contractor_application_screen/contractor_application_screen.dart';
import 'package:majed_s_application2/presentation/ministry_complaint_list_screen/ministry_complaint_list_screen.dart';
import 'package:majed_s_application2/presentation/ministry_information_screen/ministry_information_screen.dart';
import 'package:majed_s_application2/presentation/welcome_screen/welcome_screen.dart';
import 'package:majed_s_application2/services/ministry_services.dart';
import 'package:majed_s_application2/services/user_authentication.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';

// ignore_for_file: must_be_immutable
class MinistryScreen extends StatelessWidget {
  MinistryScreen({
    Key? key,
  });
  late String? ministryId;

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
                            text: "View Complaints",
                            margin: EdgeInsets.only(left: 32.h, right: 28.h),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MinistryComplaintListScreen()),
                              );
                            }),
                        SizedBox(height: 26.v),
                        CustomOutlinedButton(
                            text: "Create Contractor Account",
                            margin: EdgeInsets.only(left: 32.h, right: 28.h),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ContractorApplication()),
                              );
                            }),
                        SizedBox(height: 26.v),
                        CustomOutlinedButton(
                            text: "Profile Information",
                            margin: EdgeInsets.only(left: 32.h, right: 28.h),
                            onPressed: () async {
                              ministryId = await getMinistryId();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MinistryInformationScreen(
                                          ministryId: ministryId!,
                                          isItVisible: false,
                                        )),
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
