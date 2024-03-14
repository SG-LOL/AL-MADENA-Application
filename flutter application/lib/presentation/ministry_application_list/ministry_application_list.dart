import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/ministry_information_screen/ministry_information_screen.dart';
import 'package:majed_s_application2/services/ministry_services.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/navbar.dart';

class MinistryApplicationList extends StatefulWidget {
  const MinistryApplicationList({Key? key}) : super(key: key);

  @override
  _MinistryApplicationList createState() => _MinistryApplicationList();
}

class _MinistryApplicationList extends State<MinistryApplicationList> {
  late List<Map<String, dynamic>> ministries;

  Future<void> updateMinistries() async {
    try {
      List<dynamic> data = await fetchUnconfirmedMinistriesData();
      setState(() {
        ministries = data.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      print('Error updating ministries state: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    ministries = [];
    updateMinistries();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 101, 170, 238),
        appBar: _buildAppBar(context),
        endDrawer: Navebar(),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ministries.map((complaint) {
                return _buildMinistryCard(context, complaint);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMinistryCard(
      BuildContext context, Map<String, dynamic> ministry) {
    double cardWidth = MediaQuery.of(context).size.width - 30;

    return GestureDetector(
      onTap: () {
        final String ministryId = '${ministry['id']}';
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MinistryInformationScreen(
                    ministryId: ministryId,
                    isItVisible: true,
                  )),
        );
      },
      child: Container(
        width: cardWidth,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: ${ministry['id']}',
                style: TextStyle(color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'ministry_name: ${ministry['ministry_name']}',
                style: TextStyle(color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'phone_number: ${ministry['phone_number']}',
                style: TextStyle(color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'email: ${ministry['email']}',
                style: TextStyle(color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'city: ${ministry['city']}',
                style: TextStyle(color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'responsbility: ${ministry['resp']}',
                style: TextStyle(color: Colors.black),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 30,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 6, top: 16, bottom: 15),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      title: AppbarSubtitle(text: "Back", margin: EdgeInsets.only(left: 5)),
    );
  }

  void onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
