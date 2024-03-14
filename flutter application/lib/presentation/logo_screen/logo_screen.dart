import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';

class LogoScreen extends StatelessWidget {
  const LogoScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgShape,
                height: 234.v,
                width: 272.h,
              ),
              SizedBox(height: 70.v),
              CustomImageView(
                imagePath: ImageConstant.imgLogo1,
                height: 204.v,
                width: 233.h,
                alignment: Alignment.center,
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }
}
