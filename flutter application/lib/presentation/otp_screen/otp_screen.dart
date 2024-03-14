import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/create_profile_screen/create_profile_screen.dart';
import 'package:majed_s_application2/services/user_authentication.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';
import 'package:majed_s_application2/widgets/custom_floating_text_field.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);

  TextEditingController verficationCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 27.h, vertical: 55.v),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomImageView(
                imagePath: ImageConstant.imgOtpppp2,
                height: 260.v,
                width: 259.h),
            SizedBox(height: 38.v),
            Text(" Email Verification",
                style: CustomTextStyles.headlineSmallGray80002),
            SizedBox(height: 30.v),
            Text("Enter the OTP sent to your Email",
                style: CustomTextStyles.bodyLargeMontserratGray80002),
            SizedBox(height: 20.v),
            Padding(
              padding: EdgeInsets.only(
                left: 31.h,
                right: 28.h,
              ),
              child: CustomFloatingTextField(
                controller: verficationCode,
                hintText: "verfication code",
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.emailAddress,
                alignment: Alignment.center,
              ),
            ),
            SizedBox(height: 35.v),
            TextButton(
                onPressed: () {
                  sendVerificationEmail();
                },
                child: Text("Didnt you recieve the OTP ? Resend OTP",
                    style: TextStyle(
                        color: Color.fromARGB(200, 95, 95, 95),
                        fontSize: 18.fSize))),
            SizedBox(height: 51.v),
            CustomOutlinedButton(
                text: "Verify",
                margin: EdgeInsets.only(right: 6.h),
                buttonTextStyle:
                    CustomTextStyles.titleLargeMontserratIndigoA700,
                onPressed: () async {
                  final code = verficationCode.text;
                  final verfied = await sendVerificationCode(code);
                  if (verfied) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateProfileScreen()));
                  }
                }),
            SizedBox(height: 5.v)
          ])),
    )));
  }

  /// Navigates to the signUpScreen when the action is triggered.
  onTapVerify(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpScreen);
  }
}
