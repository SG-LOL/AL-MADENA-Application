import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';
import 'package:majed_s_application2/widgets/navbar.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            endDrawer: Navebar(),
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgShape,
                      height: 236.v,
                      width: 264.h,
                      alignment: Alignment.centerLeft),
                  Spacer(flex: 35),
                  Text(" Language ",
                      style: CustomTextStyles.headlineMediumGray80002),
                  SizedBox(height: 33.v),
                  CustomOutlinedButton(
                      text: "English",
                      margin: EdgeInsets.only(left: 28.h, right: 32.h),
                      onPressed: () {
                        onTapEnglish(context);
                      }),
                  SizedBox(height: 13.v),
                  CustomOutlinedButton(
                      text: "العربية",
                      margin: EdgeInsets.only(left: 28.h, right: 32.h),
                      onPressed: () {
                        onTaptf(context);
                      }),
                  Spacer(flex: 64)
                ]))));
  }

  onTapEnglish(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpScreen);
  }

  onTaptf(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpScreen);
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
