import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/submit_screen/detail_screen.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/navbar.dart';

// ignore_for_file: must_be_immutable
class TypeScreen extends StatelessWidget {
  final Map<String, dynamic>? complaintInfo;
  TypeScreen({Key? key, this.complaintInfo}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            endDrawer: Navebar(),
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: 380.h,
                height: 1000.v,
                margin: EdgeInsets.only(top: 3.v),
                padding: EdgeInsets.symmetric(horizontal: 7.h, vertical: 30.v),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.imgGroup20),
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    SizedBox(height: 50.v),
                    SizedBox(height: 13.v),
                    Padding(
                        padding: EdgeInsets.only(left: 7.h, right: 7.h),
                        child: _buildComplaintType(context,
                            imagePath: ImageConstant.imgStrayAnimals1,
                            text: "Animals & Pests", onTap: () {
                          onTap(context, "Animals & Pests", complaintInfo);
                        })),
                    SizedBox(height: 13.v),
                    Padding(
                      padding: EdgeInsets.only(left: 7.h, right: 7.h),
                      child: _buildComplaintType(
                        context,
                        imagePath: ImageConstant.garbage,
                        text: "Garbage & Dumpsters",
                        onTap: () {
                          onTap(context, "Garbage & Dumpsters", complaintInfo);
                        },
                      ),
                    ),
                    SizedBox(height: 13.v),
                    Padding(
                      padding: EdgeInsets.only(left: 7.h, right: 7.h),
                      child: _buildComplaintType(
                        context,
                        imagePath: ImageConstant.graffiti,
                        text: "Graffiti & Vandalism",
                        onTap: () {
                          onTap(context, "Graffiti & Vandalism", complaintInfo);
                        },
                      ),
                    ),
                    SizedBox(height: 13.v),
                    Padding(
                      padding: EdgeInsets.only(left: 7.h, right: 7.h),
                      child: _buildComplaintType(
                        context,
                        imagePath: ImageConstant.imgPathHoles1,
                        text: "Parking & Roads",
                        onTap: () {
                          onTap(context, "Parking & Roads", complaintInfo);
                        },
                      ),
                    ),
                    SizedBox(height: 13.v),
                    Padding(
                      padding: EdgeInsets.only(left: 7.h, right: 7.h),
                      child: _buildComplaintType(
                        context,
                        imagePath: ImageConstant.imgPowerAndElectricity,
                        text: "Power & electricity",
                        onTap: () {
                          onTap(context, "Power & electricity", complaintInfo);
                        },
                      ),
                    ),
                    SizedBox(height: 13.v),
                    Padding(
                      padding: EdgeInsets.only(left: 7.h, right: 7.h),
                      child: _buildComplaintType(
                        context,
                        imagePath: ImageConstant.imgFallenTrees1,
                        text: "Trees & Vegetation",
                        onTap: () {
                          onTap(context, "Trees & Vegetation", complaintInfo);
                        },
                      ),
                    ),
                    SizedBox(height: 13.v),
                    Padding(
                      padding: EdgeInsets.only(left: 7.h, right: 7.h),
                      child: _buildComplaintType(
                        context,
                        imagePath: ImageConstant.swere,
                        text: "Water & Sewer",
                        onTap: () {
                          onTap(context, "Water & Sewer", complaintInfo);
                        },
                      ),
                    ),
                  ]),
                ))));
  }

  Widget _buildComplaintType(
    BuildContext context, {
    required String imagePath,
    required String text,
    Function? onTap,
  }) {
    return GestureDetector(
        onTap: () {
          onTap!.call();
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 12.v),
            decoration: AppDecoration.outlineBlack9002
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomImageView(
                      imagePath: imagePath,
                      height: 41.v,
                      width: 39.h,
                      margin: EdgeInsets.only(bottom: 2.v)),
                  Padding(
                      padding:
                          EdgeInsets.only(left: 3.h, top: 6.v, bottom: 5.v),
                      child: Text(text,
                          style: CustomTextStyles.titleLargePoppinsGray70001
                              .copyWith(color: appTheme.gray70001)))
                ])));
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

  onTap(
      BuildContext context, String type, Map<String, dynamic>? complaintInfo) {
    if (complaintInfo != null) {
      complaintInfo['type'] = type;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailScreen(
                    complaintType: type,
                    complaintInfo: complaintInfo,
                  )));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailScreen(
                    complaintType: type,
                  )));
    }
  }
}
