import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/welcome_screen/welcome_screen.dart';
import 'package:majed_s_application2/services/input_validation.dart';
import 'package:majed_s_application2/services/user_authentication.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';
import 'package:majed_s_application2/widgets/custom_text_form_field.dart';
import 'package:majed_s_application2/widgets/navbar.dart';

// ignore_for_file: must_be_immutable
class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  TextEditingController oldPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            endDrawer: Navebar(),
            appBar: _buildAppBar(context),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SizedBox(
                width: mediaQueryData.size.width,
                child: SizedBox(
                    height: 800.v,
                    width: double.maxFinite,
                    child: Stack(alignment: Alignment.topRight, children: [
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 37.h, vertical: 40.v),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(ImageConstant.imgGroup20),
                                    fit: BoxFit.cover)),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 26.v),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 4.h),
                                          child: Text("Old Password",
                                              style:
                                                  theme.textTheme.titleLarge))),
                                  SizedBox(height: 22.v),
                                  _oldPassword(context),
                                  SizedBox(height: 26.v),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 6.h),
                                          child: Text("New Password",
                                              style:
                                                  theme.textTheme.titleLarge))),
                                  SizedBox(height: 22.v),
                                  _newPassword(context),
                                  SizedBox(height: 26.v),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 6.h),
                                          child: Text("Confirm New Password",
                                              style:
                                                  theme.textTheme.titleLarge))),
                                  SizedBox(height: 22.v),
                                  _confirmPassword(context),
                                  SizedBox(height: 77.v),
                                  _buildSave(context)
                                ]),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.only(left: 25.h, top: 30.v),
                              child: Text("Change password",
                                  style: theme.textTheme.headlineMedium)))
                    ])),
              ),
            )));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 30.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 6.h, top: 16.v, bottom: 15.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      title: AppbarSubtitle(text: "Back", margin: EdgeInsets.only(left: 5.h)),
    );
  }

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Section Widget
  Widget _oldPassword(BuildContext context) {
    return CustomTextFormField(
      controller: oldPasswordController,
      readOnly: false,
      obscureText: true,
    );
  }

  Widget _confirmPassword(BuildContext context) {
    return CustomTextFormField(
      controller: confirmPasswordController,
      readOnly: false,
      obscureText: true,
    );
  }

  /// Section Widget
  Widget _newPassword(BuildContext context) {
    return CustomTextFormField(
      controller: newPasswordController,
      readOnly: false,
      obscureText: true,
    );
  }

  /// Section Widget
  Widget _buildSave(BuildContext context) {
    return CustomOutlinedButton(
        onPressed: () async {
          String? passwordMassege = validatePassword(
              newPasswordController.text, confirmPasswordController.text);
          if (passwordMassege == null) {
            updatePassword(
                oldPasswordController.text, newPasswordController.text);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomeScreen(),
              ),
            );
          }
        },
        text: "Save",
        margin: EdgeInsets.only(left: 30.h, right: 28.h),
        buttonStyle: CustomButtonStyles.outlineWhiteA,
        buttonTextStyle: theme.textTheme.headlineSmall!);
  }
}
