import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/contractor_complaint_list_screen/contractor_complaint_list_screen.dart';
import 'package:majed_s_application2/presentation/contractor_infromation_screen/contractor_infromation_screen.dart';
import 'package:majed_s_application2/presentation/welcome_screen/welcome_screen.dart';
import 'package:majed_s_application2/services/contractor_services.dart';
import 'package:majed_s_application2/services/user_authentication.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';

// ignore_for_file: must_be_immutable
class ContractorScreen extends StatelessWidget {
  ContractorScreen({
    Key? key,
  });
  late String? contractorId;

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
                                        ContractorComplaintListScreen()),
                              );
                            }),
                        SizedBox(height: 26.v),
                        CustomOutlinedButton(
                            text: "Profile Information",
                            margin: EdgeInsets.only(left: 32.h, right: 28.h),
                            onPressed: () async {
                              contractorId = await fetchContractorId();
                              print(
                                contractorId,
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ContractorInformationScreen(
                                          isItVisible: true,
                                          contractorId: contractorId!,
                                        )),
                              );
                            }),
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
