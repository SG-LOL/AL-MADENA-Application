import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/otp_screen/otp_screen.dart';
import 'package:majed_s_application2/services/user_authentication.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';

class OtpOneScreen extends StatelessWidget {
  final String email;
  const OtpOneScreen({Key? key, required this.email})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 30.h,
            vertical: 55.v,
          ),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgOtpppp1,
                height: 260.v,
                width: 259.h,
              ),
              SizedBox(height: 54.v),
              Text(
                "Email Verification",
                style: CustomTextStyles.headlineSmallGray80002,
              ),
              SizedBox(height: 26.v),
              Container(
                width: 302.h,
                margin: EdgeInsets.only(
                  left: 3.h,
                  right: 9.h,
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "We will sent you a one-time password \nto this  Email: ",
                        style: CustomTextStyles.bodyLargeMontserratGray80002_1
                            .copyWith(
                          height: 1.50,
                        ),
                      ),
                      TextSpan(
                        text: "$email",
                        style: CustomTextStyles.titleMediumMontserratBlack900,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
              CustomOutlinedButton(
                onPressed: () async {
                  bool isTheEmailSent = await sendVerificationEmail();
                  if (isTheEmailSent) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OtpScreen()));
                  }
                },
                text: "Continue",
                buttonTextStyle:
                    CustomTextStyles.titleLargeMontserratIndigoA700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
