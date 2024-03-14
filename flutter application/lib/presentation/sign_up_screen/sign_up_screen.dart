import 'dart:async';
import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/otp_one_screen/otp_one_screen.dart';
import 'package:majed_s_application2/services/user_authentication.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';
import 'package:majed_s_application2/widgets/custom_text_form_field.dart';
import 'package:majed_s_application2/services/input_validation.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String imagePath = ImageConstant.imgPage1Gray90001;
  String imagePath1 = ImageConstant.imgPage1Gray90002;
  bool _isobscure = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void changeTextState() {
    setState(() {
      _isobscure = !_isobscure;
      if (_isobscure) {
        imagePath = ImageConstant.imgPage1Gray90001;
      } else {
        imagePath = ImageConstant.imgPage1Gray90002;
      }
    });
  }

  void updateTextAndRevert() {
    changeTextState();

    Timer(Duration(seconds: 3), () {
      changeTextState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgShape,
                    height: 244.v,
                    width: 255.h,
                  ),
                  SizedBox(height: 91.v),
                  Padding(
                    padding: EdgeInsets.only(left: 23.h),
                    child: Text(
                      "Sign up",
                      style: CustomTextStyles.headlineMediumGray80002,
                    ),
                  ),
                  SizedBox(height: 26.v),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 31.h,
                      right: 28.h,
                    ),
                    child: CustomTextFormField(
                      controller: emailController,
                      readOnly: false,
                      hintText: "Email",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                      alignment: Alignment.center,
                      suffix: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 28.v, 19.h, 5.v),
                        child: CustomImageView(
                          imagePath: null,
                          height: 14.v,
                          width: 18.h,
                        ),
                      ),
                      suffixConstraints: BoxConstraints(
                        maxHeight: 48.v,
                      ),
                      obscureText: false,
                      borderDecoration:
                          TextFormFieldStyleHelper.underLineSecondaryContainer,
                    ),
                  ),
                  SizedBox(height: 26.v),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 31.h,
                      right: 28.h,
                    ),
                    child: CustomTextFormField(
                      controller: passwordController,
                      readOnly: false,
                      hintText: "password",
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: _isobscure,
                      borderDecoration:
                          TextFormFieldStyleHelper.underLineSecondaryContainer,
                      alignment: Alignment.center,
                      suffix: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 28.v, 19.h, 5.v),
                        child: CustomImageView(
                          imagePath: imagePath,
                          height: 14.v,
                          width: 18.h,
                          onTap: () {
                            setState(() {
                              updateTextAndRevert();
                            });
                          },
                        ),
                      ),
                      suffixConstraints: BoxConstraints(
                        maxHeight: 48.v,
                      ),
                    ),
                  ),
                  SizedBox(height: 26.v),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 31.h,
                      right: 28.h,
                    ),
                    child: CustomTextFormField(
                      controller: confirmpasswordController,
                      readOnly: false,
                      hintText: "Confirm password",
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: _isobscure,
                      alignment: Alignment.center,
                      suffix: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 28.v, 19.h, 5.v),
                        child: CustomImageView(
                          imagePath: imagePath,
                          height: 14.v,
                          width: 18.h,
                          onTap: () {
                            setState(() {
                              updateTextAndRevert();
                            });
                          },
                        ),
                      ),
                      suffixConstraints: BoxConstraints(
                        maxHeight: 48.v,
                      ),
                      borderDecoration:
                          TextFormFieldStyleHelper.underLineSecondaryContainer,
                    ),
                  ),
                  SizedBox(height: 89.v, width: 315.h),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 31.h,
                      right: 28.h,
                    ),
                    child: CustomOutlinedButton(
                      width: 315.h,
                      text: "Continue",
                      buttonStyle: CustomButtonStyles.outlineOnError,
                      buttonTextStyle:
                          CustomTextStyles.titleLargeMontserratIndigoA700,
                      alignment: Alignment.topCenter,
                      onPressed: () {
                        final emailAddress = emailController.text;
                        final password = passwordController.text;
                        final cpassword = confirmpasswordController.text;
                        if (validateEmail(emailAddress) == null) {
                          if (validatePassword(password, cpassword) == null) {
                            register(emailAddress, password);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OtpOneScreen(
                                  email: emailAddress,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
