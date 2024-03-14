import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/ministry_confirmation_screen/ministry_confirmation_screen.dart';
import 'package:majed_s_application2/services/ministry_services.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';
import 'package:majed_s_application2/widgets/custom_text_form_field.dart';
import 'package:majed_s_application2/widgets/navbar.dart';

class MinistryApplication extends StatefulWidget {
  @override
  _MinistryApplicationState createState() => _MinistryApplicationState();
}

class _MinistryApplicationState extends State<MinistryApplication> {
  List<String> getSelected(List<bool> isCheckedList) {
    List<String> selected = [];
    for (int i = 0; i < isCheckedList.length; i++) {
      if (isCheckedList[i]) {
        selected.add(responsibilities[i]);
      }
    }

    return selected;
  }

  List<bool> isCheckedList = List.generate(7, (index) => false);
  List<String> responsibilities = [
    "Animals & Pests",
    "Garbage & Dumpsters",
    "Graffiti & Vandalism",
    "Parking & Roads",
    "Power & electricity",
    "Trees & Vegetation",
    "Water & Sewer",
  ];

  TextEditingController phoneNumberContoller = TextEditingController();
  TextEditingController ministryNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
              height: 1400.v,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 37.h, vertical: 40.v),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImageConstant.imgGroup20),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 24.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.h),
                              child: Text(
                                "Email Address",
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                          ),
                          SizedBox(height: 13.v),
                          _buildEmail(context),
                          SizedBox(height: 24.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.h),
                              child: Text(
                                "Ministry Name",
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                          ),
                          SizedBox(height: 13.v),
                          _buildMinistryName(context),
                          SizedBox(height: 24.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.h),
                              child: Text(
                                "Ministry City",
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                          ),
                          SizedBox(height: 13.v),
                          _buildCity(context),
                          SizedBox(height: 24.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.h),
                              child: Text(
                                "Password",
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                          ),
                          SizedBox(height: 13.v),
                          _buildPassword(context),
                          SizedBox(height: 24.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.h),
                              child: Text(
                                "Password confirmation",
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                          ),
                          SizedBox(height: 13.v),
                          _buildConfirmPassword(context),
                          SizedBox(height: 24.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.h),
                              child: Text(
                                "phone number",
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                          ),
                          SizedBox(height: 13.v),
                          _buildPhoneNumber(context),
                          SizedBox(height: 24.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.h),
                              child: Text(
                                "Responsibilities",
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                          ),
                          SizedBox(height: 13.v),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              padding: EdgeInsets.all(16.0),
                              child: _buildCheckboxes(context),
                            ),
                          ),
                          SizedBox(height: 77.v),
                          _buildSave(context),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 25.h, top: 30.v),
                      child: Text(
                        "ministry infromation",
                        style: theme.textTheme.headlineMedium,
                      ),
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

  Widget _buildPhoneNumber(BuildContext context) {
    return CustomTextFormField(
      controller: phoneNumberContoller,
      readOnly: false,
    );
  }

  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
      controller: emailController,
      readOnly: false,
    );
  }

  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
      obscureText: true,
      controller: passwordController,
      readOnly: false,
    );
  }

  Widget _buildCity(BuildContext context) {
    return CustomTextFormField(
      controller: cityController,
      readOnly: false,
    );
  }

  Widget _buildConfirmPassword(BuildContext context) {
    return CustomTextFormField(
      obscureText: true,
      controller: confirmpasswordController,
      readOnly: false,
    );
  }

  Widget _buildMinistryName(BuildContext context) {
    return CustomTextFormField(
      controller: ministryNameController,
      readOnly: false,
    );
  }

  Widget _buildCheckboxes(BuildContext context) {
    List<Widget> checkboxes = [];

    for (int i = 0; i < 7; i++) {
      checkboxes.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              activeColor: Color.fromARGB(255, 101, 170, 238),
              checkColor: Colors.transparent,
              value: isCheckedList[i],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    isCheckedList[i] = value;
                  });
                }
              },
            ),
            SizedBox(width: 8.0),
            Text(
              responsibilities[i],
              style: theme.textTheme.titleLarge,
            ),
          ],
        ),
      );
    }

    return Column(
      children: checkboxes,
    );
  }

  Widget _buildSave(BuildContext context) {
    return CustomOutlinedButton(
        onPressed: () {
          createMinistry(
              emailController.text,
              ministryNameController.text,
              phoneNumberContoller.text,
              cityController.text,
              passwordController.text,
              getSelected(isCheckedList));
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MinistryConfirmationScreen()),
          );
        },
        text: "apply now",
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
