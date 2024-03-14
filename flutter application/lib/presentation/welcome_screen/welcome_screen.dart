import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/ministry_application_screen/ministry_application_screen.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgShape,
                      height: 239.v,
                      width: 255.h,
                      alignment: Alignment.centerLeft),
                  Spacer(flex: 37),
                  Text("Welcome!", style: CustomTextStyles.headlineMediumBold),
                  SizedBox(height: 29.v),
                  Container(
                      width: 343.h,
                      margin: EdgeInsets.only(left: 15.h, right: 16.h),
                      child: Text(
                          "Join Al-Madina community to start using\n our services",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.titleMediumMontserratGray80002
                              .copyWith(height: 1.50))),
                  SizedBox(height: 26.v),
                  CustomOutlinedButton(
                      text: "Sign Up",
                      margin: EdgeInsets.only(left: 32.h, right: 28.h),
                      onPressed: () {
                        onTapSignUp(context);
                      }),
                  SizedBox(height: 26.v),
                  CustomOutlinedButton(
                      text: "Sign in",
                      margin: EdgeInsets.only(left: 32.h, right: 28.h),
                      onPressed: () {
                        onTapSignIn(context);
                      }),
                  Spacer(flex: 62),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 25.h, right: 25.h, bottom: 25.v),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MinistryApplication()),
                            );
                          },
                          child: Text("For Ministries Apply Now to Join Us",
                              style: CustomTextStyles
                                  .bodyLargeMontserratGray80002_1)))
                ]))));
  }

  /// Navigates to the signUpScreen when the action is triggered.
  onTapSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpScreen);
  }

  onTapSignIn(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signInScreen);
  }
}
