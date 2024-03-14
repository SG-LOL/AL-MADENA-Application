import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';
import 'package:majed_s_application2/widgets/custom_text_form_field.dart';
import 'package:requests/requests.dart';

// ignore: must_be_immutable
class RecoverAccount extends StatelessWidget {
  RecoverAccount({Key? key})
      : super(
          key: key,
        );
  TextEditingController emailController = TextEditingController();

  Future<bool> sendVerificationEmail() async {
    try {
      final response =
          await Requests.post('http://10.0.2.2:5000//recovery_email');

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                      onPressed: () async {}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
