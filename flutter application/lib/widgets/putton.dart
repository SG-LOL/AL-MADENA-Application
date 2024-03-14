import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 242.v,
                        width: 252.h,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 25.h),
                          child: Text("Sign In",
                              style: CustomTextStyles.headlineMediumGray80002)),
                      SizedBox(height: 30.v),
                      Padding(
                          padding: EdgeInsets.only(left: 33.h),
                          child: Text("Email Address",
                              style:
                                  CustomTextStyles.bodyMediumABeeZeeGray40014)),
                      SizedBox(height: 30.v),
                      Padding(
                          padding: EdgeInsets.only(left: 33.h),
                          child: Text("Password",
                              style:
                                  CustomTextStyles.bodyMediumABeeZeeGray40014)),
                      SizedBox(height: 9.v),
                      Container(
                          margin: EdgeInsets.only(left: 30.h),
                          decoration: AppDecoration.outlineBlack,
                          child: Text("Forgot Password?",
                              style:
                                  CustomTextStyles.bodyMediumABeeZeeGray80002)),
                      Spacer(flex: 20),
                      SizedBox(height: 56.v),
                      _buildSignIn(context)
                    ]))));
  }

  /// Section Widget
  Widget _buildSignIn(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: SizedBox(
            height: 79.v,
            width: 315.h,
            child: Stack(alignment: Alignment.bottomRight, children: [
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 23.h),
                      child: Text("Sign In",
                          style: CustomTextStyles
                              .titleLargeMontserratWhiteA700_1))),
              CustomImageView(
                  imagePath: ImageConstant.imgRightArrow1,
                  height: 15.v,
                  width: 19.h,
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(right: 26.h, bottom: 7.v)),
              CustomOutlinedButton(
                  width: 315.h,
                  text: "Sign  In",
                  buttonTextStyle:
                      CustomTextStyles.titleLargeMontserratIndigoA700,
                  onPressed: () {
                    onTapSignIn(context);
                  },
                  alignment: Alignment.topCenter)
            ])));
  }

  /// Navigates to the signUpScreen when the action is triggered.
  onTapSignIn(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpScreen);
  }
}
