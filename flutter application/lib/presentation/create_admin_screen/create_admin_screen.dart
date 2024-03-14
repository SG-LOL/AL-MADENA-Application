import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/admin_screen/admin_screen.dart';
import 'package:majed_s_application2/services/admin_services.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';
import 'package:majed_s_application2/widgets/custom_text_form_field.dart';
import 'package:majed_s_application2/widgets/navbar.dart';

// ignore_for_file: must_be_immutable
class CreateAdmin extends StatelessWidget {
  CreateAdmin({
    Key? key,
  }) : super(key: key);

  TextEditingController phoneNumberContoller = TextEditingController();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController nationalIdController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

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
                    height: 1200.v,
                    width: double.maxFinite,
                    child: Stack(alignment: Alignment.topRight, children: [
                      Align(
                          alignment: Alignment.topCenter,
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
                                  SizedBox(height: 24.v),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 4.h),
                                          child: Text("Email Address",
                                              style:
                                                  theme.textTheme.titleLarge))),
                                  SizedBox(height: 13.v),
                                  _buildEmail(context),
                                  SizedBox(height: 24.v),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 4.h),
                                          child: Text("Password",
                                              style:
                                                  theme.textTheme.titleLarge))),
                                  SizedBox(height: 13.v),
                                  _buildPassword(context),
                                  SizedBox(height: 24.v),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 4.h),
                                          child: Text("Confirm The Password",
                                              style:
                                                  theme.textTheme.titleLarge))),
                                  SizedBox(height: 13.v),
                                  _buildConfirmPassword(context),
                                  SizedBox(height: 24.v),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 4.h),
                                          child: Text("nathonail id",
                                              style:
                                                  theme.textTheme.titleLarge))),
                                  SizedBox(height: 13.v),
                                  _buildNationalId(context),
                                  SizedBox(height: 21.v),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 6.h, right: 28.h),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("First Name",
                                                    style: theme
                                                        .textTheme.titleLarge),
                                                Text("Last Name",
                                                    style: theme
                                                        .textTheme.titleLarge)
                                              ]))),
                                  SizedBox(height: 12.v),
                                  _buildFullName(context),
                                  SizedBox(height: 24.v),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 4.h),
                                          child: Text("phone number",
                                              style:
                                                  theme.textTheme.titleLarge))),
                                  SizedBox(height: 13.v),
                                  _buildPhoneNumber(context),
                                  SizedBox(height: 26.v),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 6.h),
                                          child: Text("Date Of Birth",
                                              style:
                                                  theme.textTheme.titleLarge))),
                                  SizedBox(height: 22.v),
                                  _buildDateOfBirth(context),
                                  SizedBox(height: 77.v),
                                  _buildSave(context)
                                ]),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.only(left: 25.h, top: 30.v),
                              child: Text("admin account information",
                                  style: theme.textTheme.headlineMedium)))
                    ])),
              ),
            )));
  }

  Widget _buildPhoneNumber(BuildContext context) {
    return CustomTextFormField(
        controller: phoneNumberContoller, readOnly: false);
  }

  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(controller: emailController, readOnly: false);
  }

  Widget _buildNationalId(BuildContext context) {
    return CustomTextFormField(
        controller: nationalIdController, readOnly: false);
  }

  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
        obscureText: true, controller: passwordController, readOnly: false);
  }

  Widget _buildConfirmPassword(BuildContext context) {
    return CustomTextFormField(
        obscureText: true,
        controller: confirmpasswordController,
        readOnly: false);
  }

  Widget _buildFirstName(BuildContext context) {
    return CustomTextFormField(
      width: 130.h,
      controller: firstNameController,
      readOnly: false,
    );
  }

  Widget _buildLastName(BuildContext context) {
    return CustomTextFormField(
        width: 134.h, controller: lastNameController, readOnly: false);
  }

  Widget _buildFullName(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildFirstName(context), _buildLastName(context)]);
  }

  Widget _buildDateOfBirth(BuildContext context) {
    return CustomTextFormField(
        hintText: 'DD-MM-YYYY',
        controller: dateOfBirthController,
        readOnly: false,
        textInputAction: TextInputAction.done);
  }

  Widget _buildSave(BuildContext context) {
    return CustomOutlinedButton(
        onPressed: () {
          createAdmin(
              emailController.text,
              firstNameController.text,
              lastNameController.text,
              phoneNumberContoller.text,
              dateOfBirthController.text,
              nationalIdController.text,
              passwordController.text);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminScreen(),
            ),
          );
        },
        text: "create account",
        margin: EdgeInsets.only(left: 30.h, right: 28.h),
        buttonStyle: CustomButtonStyles.outlineWhiteA,
        buttonTextStyle: theme.textTheme.headlineSmall!);
  }

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
}
