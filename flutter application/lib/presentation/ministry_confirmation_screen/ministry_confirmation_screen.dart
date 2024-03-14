import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/welcome_screen/welcome_screen.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';
import 'package:majed_s_application2/widgets/navbar.dart';

class MinistryConfirmationScreen extends StatelessWidget {
  const MinistryConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        endDrawer: Navebar(),
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 35.v),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            children: [
              Container(
                height: 110.adaptSize,
                width: 110.adaptSize,
                padding: EdgeInsets.symmetric(horizontal: 31.h, vertical: 38.v),
                decoration: AppDecoration.fillIndigo.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder55,
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.imgPath,
                  height: 33.v,
                  width: 46.h,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 20.v),
              Text(
                "Thank You",
                style: CustomTextStyles.titleMediumMontserratIndigoA70001,
              ),
              SizedBox(height: 9.v),
              SizedBox(
                width: 210.h,
                child: Text(
                  "Your application under review",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style:
                      CustomTextStyles.bodyLargeMontserratIndigoA70001.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              SizedBox(height: 89.v, width: 315.h),
              Padding(
                padding: EdgeInsets.only(
                  left: 31.h,
                  right: 28.h,
                ),
                child: CustomOutlinedButton(
                    width: 350.h,
                    text: "Back to Home Screen",
                    buttonStyle: CustomButtonStyles.outlineOnError,
                    buttonTextStyle:
                        CustomTextStyles.titleLargeMontserratIndigoA700,
                    alignment: Alignment.topCenter,
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
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
}
