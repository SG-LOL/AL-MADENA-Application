import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/complaint_list_screen/complaint_list_screen.dart';
import 'package:majed_s_application2/presentation/type_screen/type_screen.dart';
import 'package:majed_s_application2/services/complaint_services.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';
import 'package:majed_s_application2/widgets/navbar.dart';
import 'package:requests/requests.dart';

class ComplaintListoneScreen extends StatefulWidget {
  final String complaintId;

  ComplaintListoneScreen({Key? key, required this.complaintId})
      : super(key: key);

  @override
  _ComplaintListoneScreenState createState() => _ComplaintListoneScreenState();
}

class _ComplaintListoneScreenState extends State<ComplaintListoneScreen> {
  late MediaQueryData mediaQueryData;

  Map<String, dynamic> complaintInfo = {};

  @override
  void initState() {
    super.initState();
    _getComplaint(widget.complaintId);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 101, 170, 238),
        resizeToAvoidBottomInset: false,
        endDrawer: Navebar(),
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(), child: _buildBody()),
      ),
    );
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

  void onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> _getComplaint(String complaintId) async {
    final fetchedComplaintInfo = await fetchCitizenComplaint(complaintId);
    if (fetchedComplaintInfo != null) {
      setState(() {
        complaintInfo = fetchedComplaintInfo;
      });
    }
  }

  Widget _buildBody() {
    // Use a FutureBuilder to wait for the delay
    return FutureBuilder(
      future: Future.delayed(
          Duration(seconds: 2)), // Introduce a delay of 2 seconds
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting, show a loading indicator
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // After the delay, check if complaintInfo is empty
          if (complaintInfo.isEmpty) {
            return Center(
              child: Text('No complaints available'), // Placeholder text
            );
          } else {
            return ComplaintCard(complaintInfo: complaintInfo);
          }
        }
      },
    );
  }
}

class ComplaintCard extends StatelessWidget {
  final Map<String, dynamic> complaintInfo;

  ComplaintCard({required this.complaintInfo});

  Future<void> deleteComplaint(String complaintId) async {
    try {
      final response = await Requests.delete(
          'http://10.0.2.2:5000/delete_complaint/$complaintId');

      if (response.statusCode == 200) {
        print("Complaint deleted successfully");
      } else {
        print(
            "Failed to delete complaint. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isItVisible = false;
    if ('${complaintInfo['visible']}' == 'true') {
      isItVisible = true;
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 16.0),
      _buildCard('Complaint ID', '${complaintInfo['complaint_id']}'),
      _buildCard('Date', '${complaintInfo['date']}'.substring(0, 17)),
      _buildCard('Type', '${complaintInfo['type']}'),
      _buildCard('Location',
          ' ${complaintInfo['location']['city']}, ${complaintInfo['location']['street']}'),
      _buildCard('description', '${complaintInfo['description']}'),
      _buildCard('Status', '${complaintInfo['status']}'),
      _buildPhotosCard('Photos', complaintInfo['photos']),
      _buildButtonCard(isItVisible, '${complaintInfo['complaint_id']}', context)
    ]);
  }

  Widget _buildPhotosCard(String title, List<dynamic> photos) {
    if (photos.isNotEmpty) {
      return Card(
        elevation: 0,
        shadowColor: Colors.transparent,
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            ListTile(title: Text('$title:')),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
                  child: Image.memory(
                    base64.decode(photos[index]),
                  ),
                );
              },
            ),
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildCard(String title, String content) {
    return Card(
      elevation: 0,
      shadowColor: Colors.transparent,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text('$title: $content', style: TextStyle(color: Colors.black)),
      ),
    );
  }

  Widget _buildButtonCard(bool isItVisible, String id, BuildContext context) {
    return Visibility(
      visible: isItVisible,
      child: Card(
        elevation: 0,
        shadowColor: Colors.transparent,
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomOutlinedButton(
                  width: 315.h,
                  text: "Delete Complaint",
                  buttonStyle: CustomButtonStyles.outlineOnError,
                  buttonTextStyle:
                      CustomTextStyles.titleLargeMontserratIndigoA700,
                  alignment: Alignment.topCenter,
                  onPressed: () {
                    deleteComplaint(id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ComplaintListScreen()));
                  }),
              SizedBox(height: 16.0),
              CustomOutlinedButton(
                width: 315.h,
                text: "Edit Complaint",
                buttonStyle: CustomButtonStyles.outlineOnError,
                buttonTextStyle:
                    CustomTextStyles.titleLargeMontserratIndigoA700,
                alignment: Alignment.topCenter,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TypeScreen(
                                complaintInfo: complaintInfo,
                              )));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
