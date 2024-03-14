// ignore_for_file: must_be_immutable,
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/services/complaint_services.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';
import 'package:majed_s_application2/widgets/navbar.dart';

class MinistryCompalintInfoScreen extends StatefulWidget {
  final String complaintId;

  MinistryCompalintInfoScreen({Key? key, required this.complaintId})
      : super(key: key);

  @override
  _MinistryCompalintInfoScreenState createState() =>
      _MinistryCompalintInfoScreenState();
}

class _MinistryCompalintInfoScreenState
    extends State<MinistryCompalintInfoScreen> {
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
    final fetchedComplaintInfo = await fetchMinistryComplaint(complaintId);
    if (fetchedComplaintInfo != null) {
      setState(() {
        complaintInfo = fetchedComplaintInfo;
      });
    }
  }

  Widget _buildBody() {
    if (complaintInfo.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ComplaintCard(complaintInfo: complaintInfo);
    }
  }
}

class ComplaintCard extends StatelessWidget {
  final Map<String, dynamic> complaintInfo;

  List<String> severities = [
    'select severity level',
    'Low Severity (Minor Issues)',
    'Medium Severity (Moderate Issues)',
    'High Severity (Major Issues)',
    'Critical Severity (Urgent Issues)',
    'Emergency Severity (Immediate Attention Required)',
  ];

  ComplaintCard({required this.complaintInfo});

  late MediaQueryData mediaQueryData;
  int ministryIdInt = -1;
  String severity = ' ';

  @override
  Widget build(BuildContext context) {
    bool isItVisible = false;
    if ('${complaintInfo['visible']}' == 'true') {
      isItVisible = true;
    }
    List<String> contractorList = List<String>.from(
        complaintInfo['list'] ?? ['no contractor is available']);
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
      Visibility(
        visible: isItVisible,
        child: Column(
          children: [
            _buildDropDownListCard(
              'contrators list',
              context,
              contractorList,
              contractorList.first,
              (String? value) {
                if (value != null) {
                  ministryIdInt = int.parse(value);
                }
              },
            ),
            _buildDropDownListCard(
              'severity',
              context,
              severities,
              '${complaintInfo['severity']}',
              (String? value) {
                if (value != null) {
                  severity = value;
                }
              },
            ),
            _buildButtonCard(int.parse('${complaintInfo['complaint_id']}'))
          ],
        ),
      ),
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

  Widget _buildButtonCard(
    int id,
  ) {
    return Card(
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
                text: "assign contractor",
                buttonStyle: CustomButtonStyles.outlineOnError,
                buttonTextStyle:
                    CustomTextStyles.titleLargeMontserratIndigoA700,
                alignment: Alignment.topCenter,
                onPressed: () {
                  assignContractor(id, ministryIdInt, severity);
                }),
            SizedBox(height: 16.0),
            CustomOutlinedButton(
              width: 315.h,
              text: "decline complaint",
              buttonStyle: CustomButtonStyles.outlineOnError,
              buttonTextStyle: CustomTextStyles.titleLargeMontserratIndigoA700,
              alignment: Alignment.topCenter,
              onPressed: () {
                declineComplaint(id);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropDownListCard(
    String title,
    BuildContext context,
    List<String> dropdownItems,
    String initialSelection,
    void Function(String?) onItemSelected,
  ) {
    return Card(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            DropdownMenu<String>(
              width: MediaQuery.of(context).size.width - 48,
              initialSelection: initialSelection,
              onSelected: onItemSelected,
              dropdownMenuEntries:
                  dropdownItems.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(
                    value: value.split(', ')[0], label: value);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
