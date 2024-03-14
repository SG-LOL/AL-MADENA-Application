import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/create_profile_screen/create_profile_screen.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';
import 'package:majed_s_application2/widgets/custom_text_form_field.dart';
import 'package:majed_s_application2/widgets/navbar.dart';
import 'package:requests/requests.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late MediaQueryData mediaQueryData;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
                    padding:
                        EdgeInsets.symmetric(horizontal: 37.h, vertical: 40.v),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageConstant.imgGroup20),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(height: 21.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 6.h, right: 28.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("First Name",
                                  style: theme.textTheme.titleLarge),
                              Text("Last Name",
                                  style: theme.textTheme.titleLarge)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12.v),
                      _buildNinetyThree(context),
                      SizedBox(height: 24.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 4.h),
                          child: Text("Email address",
                              style: theme.textTheme.titleLarge),
                        ),
                      ),
                      SizedBox(height: 13.v),
                      _buildEmail(context),
                      SizedBox(height: 24.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 4.h),
                          child: Text("phone number",
                              style: theme.textTheme.titleLarge),
                        ),
                      ),
                      SizedBox(height: 13.v),
                      _buildPhoneNumber(context),
                      SizedBox(height: 26.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 6.h),
                          child: Text("Date Of Birth",
                              style: theme.textTheme.titleLarge),
                        ),
                      ),
                      SizedBox(height: 22.v),
                      _buildDateOfBirth(context),
                      SizedBox(height: 77.v),
                      _buildSave(context),
                    ]),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25.h, top: 30.v),
                    child:
                        Text("Profile", style: theme.textTheme.headlineMedium),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumber(BuildContext context) {
    return CustomTextFormField(
        controller: phoneNumberController, readOnly: true);
  }

  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(controller: emailController, readOnly: true);
  }

  Widget _buildFirstName(BuildContext context) {
    return CustomTextFormField(
        width: 130.h, controller: firstNameController, readOnly: true);
  }

  Widget _buildLastName(BuildContext context) {
    return CustomTextFormField(
        width: 134.h, controller: lastNameController, readOnly: true);
  }

  Widget _buildNinetyThree(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildFirstName(context), _buildLastName(context)]);
  }

  Widget _buildDateOfBirth(BuildContext context) {
    return CustomTextFormField(
        hintText: 'DD-MM-YYYY',
        controller: dateOfBirthController,
        readOnly: true,
        textInputAction: TextInputAction.done);
  }

  Widget _buildSave(BuildContext context) {
    return CustomOutlinedButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateProfileScreen(
                      fName: firstNameController.text,
                      lName: lastNameController.text,
                      phoneNumber: phoneNumberController.text,
                      birthDate: dateOfBirthController.text,
                    )),
          );
        },
        text: "Edit Profile",
        margin: EdgeInsets.only(left: 30.h, right: 28.h),
        buttonStyle: CustomButtonStyles.outlineWhiteA,
        buttonTextStyle: theme.textTheme.headlineSmall!);
  }

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    final response = await Requests.get('http://10.0.2.2:5000/citizen_info');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      setState(() {
        phoneNumberController.text = data['phone_number'];
        emailController.text = data['email'];
        firstNameController.text = data['first_name'];
        lastNameController.text = data['last_name'];
        dateOfBirthController.text = data['date_of_birth'];
      });
    } else {
      print('Failed to load user information');
    }
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
