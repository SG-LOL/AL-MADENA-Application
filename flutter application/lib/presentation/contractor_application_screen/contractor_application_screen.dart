import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/ministry_confirmation_screen/ministry_confirmation_screen.dart';
import 'package:majed_s_application2/services/contractor_services.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';
import 'package:majed_s_application2/widgets/custom_radio_group.dart';
import 'package:majed_s_application2/widgets/custom_text_form_field.dart';
import 'package:majed_s_application2/widgets/navbar.dart';

class ContractorApplication extends StatefulWidget {
  @override
  _ContractorApplicationState createState() => _ContractorApplicationState();
}

class _ContractorApplicationState extends State<ContractorApplication> {
  String selectedValue = '';
  List<String> specialties = [
    "Animals & Pests",
    "Garbage & Dumpsters",
    "Graffiti & Vandalism",
    "Parking & Cars",
    "Power & electricity",
    "Trees & Vegetation",
    "Water & Sewer",
  ];

  TextEditingController phoneNumberContoller = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController contractorCityController = TextEditingController();
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
              height: 1500.v,
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
                                "company name",
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                          ),
                          SizedBox(height: 13.v),
                          _buildContractorName(context),
                          SizedBox(height: 24.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.h),
                              child: Text(
                                "company City",
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
                                "specialty",
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                          ),
                          SizedBox(height: 13.v),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: RadioGroup(
                              options: specialties,
                              selectedOption: selectedValue,
                              onChanged: (selected) {
                                setState(() {
                                  selectedValue = selected;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10.v,
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
                        "contractor infromation",
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
      controller: contractorCityController,
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

  Widget _buildContractorName(BuildContext context) {
    return CustomTextFormField(
      controller: companyNameController,
      readOnly: false,
    );
  }

  Widget _buildSave(BuildContext context) {
    return CustomOutlinedButton(
        onPressed: () {
          createContractor(
            companyName: companyNameController.text,
            phoneNumber: phoneNumberContoller.text,
            email: emailController.text,
            contractorCity: contractorCityController.text,
            password: passwordController.text,
            specialty: selectedValue,
          );
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
