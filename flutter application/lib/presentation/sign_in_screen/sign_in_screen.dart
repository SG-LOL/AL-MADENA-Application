import 'dart:async';
import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/admin_screen/admin_screen.dart';
import 'package:majed_s_application2/presentation/change_password_screen/change_password_screen.dart';
import 'package:majed_s_application2/presentation/contractor_screen/contractor_screen.dart';
import 'package:majed_s_application2/presentation/create_profile_screen/create_profile_screen.dart';
import 'package:majed_s_application2/presentation/ministry_confirmation_screen/ministry_confirmation_screen.dart';
import 'package:majed_s_application2/presentation/ministry_screen/ministry_screen.dart';
import 'package:majed_s_application2/presentation/otp_one_screen/otp_one_screen.dart';
import 'package:majed_s_application2/presentation/recover_account_screen/recover_account_acreen.dart';
import 'package:majed_s_application2/presentation/reviewer_screen/reviewer_screen.dart';
import 'package:majed_s_application2/presentation/type_screen/type_screen.dart';
import 'package:majed_s_application2/services/fcm_services.dart';
import 'package:majed_s_application2/services/user_authentication.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';
import 'package:majed_s_application2/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isobscure = true;
  String imagePath = ImageConstant.imgPage1Gray90001;
  String imagePath1 = ImageConstant.imgPage1Gray90002;

  void checkLoginResult(Map<String, dynamic> loginResult, String email) {
    if (loginResult.containsKey('message')) {
      String message = loginResult['message'];
      print('Login message: $message');

      if (message == 'complete profile information') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TypeScreen(),
          ),
        );
      } else if (message == 'incomplete profile information') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateProfileScreen(),
          ),
        );
      } else if (message == 'account is not verified') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpOneScreen(
              email: email,
            ),
          ),
        );
      } else if (message == 'admin login') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminScreen(),
          ),
        );
      } else if (message == 'change password') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangePasswordScreen(),
          ),
        );
      } else if (message == 'reviewer login') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReviewerScreen(),
          ),
        );
      } else if (message == 'ministry login') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MinistryScreen(),
          ),
        );
      } else if (message == 'waiting for confirmation') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MinistryConfirmationScreen(),
          ),
        );
      } else if (message == 'contactor login') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContractorScreen(),
          ),
        );
      } else if (message == 'incorrect password or email') {}
    } else {
      print('Unexpected response format');
    }
  }

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
      print('hello');
      changeTextState();
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
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
                      "Sign In",
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
                  SizedBox(height: 10.v),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25.h,
                      right: 28.h,
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecoverAccount(),
                            ),
                          );
                        },
                        child: Text("Forgot Your Password?",
                            style: TextStyle(
                                color: Color.fromARGB(200, 95, 95, 95),
                                fontSize: 18.fSize))),
                  ),
                  SizedBox(height: 89.v, width: 315.h),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 31.h,
                      right: 28.h,
                    ),
                    child: CustomOutlinedButton(
                        width: 315.h,
                        text: "Sign In",
                        buttonStyle: CustomButtonStyles.outlineOnError,
                        buttonTextStyle:
                            CustomTextStyles.titleLargeMontserratIndigoA700,
                        alignment: Alignment.topCenter,
                        onPressed: () async {
                          String email = emailController.text;
                          String password = passwordController.text;
                          Map<String, dynamic> result =
                              await loginUser(email, password);
                          checkLoginResult(result, email);
                          Fcm.getFcmToken();
                        }),
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
