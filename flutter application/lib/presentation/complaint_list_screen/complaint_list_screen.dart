import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/complaint_listone_screen/complaint_listone_screen.dart';
import 'package:majed_s_application2/services/complaint_services.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/custom_checkbox.dart';
import 'package:majed_s_application2/widgets/navbar.dart';

class ComplaintListScreen extends StatefulWidget {
  const ComplaintListScreen({Key? key}) : super(key: key);

  @override
  _ComplaintListScreenState createState() => _ComplaintListScreenState();
}

class _ComplaintListScreenState extends State<ComplaintListScreen> {
  late List<Map<String, dynamic>> _complaints;
  List<String> selectedTypes = [];
  List<String> selectedSeverities = [];
  List<String> selectedStates = [];

  final List<String> types = [
    "Animals & Pests",
    "Garbage & Dumpsters",
    "Graffiti & Vandalism",
    "Parking & Roads",
    "Power & electricity",
    "Trees & Vegetation",
    "Water & Sewer",
  ];
  final List<String> severities = [
    'Low Severity (Minor Issues)',
    'Medium Severity (Moderate Issues)',
    'High Severity (Major Issues)',
    'Critical Severity (Urgent Issues)',
    'Emergency Severity (Immediate Attention Required)',
  ];
  final List<String> states = [
    'Received',
    'declined',
    'Transferred to Authorities',
    'Assigned to Contractor',
    'In Progress',
    'Completed',
    'Closed',
  ];

  @override
  void initState() {
    super.initState();
    _complaints = [];
    _getComplaints();
  }

  Future<void> _getComplaints() async {
    final complaintsData = await fetchComplaints(
        selectedTypes, selectedSeverities, selectedStates);
    setState(() {
      _complaints = complaintsData;
    });
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
              children: [
                _buildfilterCard(),
                for (Map<String, dynamic> complaint in _complaints)
                  _buildComplaintCard(context, complaint),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComplaintCard(
      BuildContext context, Map<String, dynamic> complaint) {
    double cardWidth = MediaQuery.of(context).size.width - 30;

    return GestureDetector(
      onTap: () {
        final String complaintId = '${complaint['complaint_id']}';
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ComplaintListoneScreen(complaintId: complaintId)),
        );
      },
      child: Container(
        width: cardWidth,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                'Complaint ID: ${complaint['complaint_id']}',
                style: TextStyle(color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Date: ${complaint['date'].substring(0, 17)}',
                style: TextStyle(color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Type: ${complaint['type']}',
                style: TextStyle(color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Location: ${complaint['location']['city']}, ${complaint['location']['street']}',
                style: TextStyle(color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Description: ${complaint['description']}',
                style: TextStyle(color: Colors.black),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Status: ${complaint['status']}',
                style: TextStyle(color: Colors.red, fontSize: 20),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildfilterCard() {
    double cardWidth = MediaQuery.of(context).size.width - 30;

    return Container(
        width: cardWidth,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black),
        ),
        child: ExpansionTile(
          collapsedTextColor: Color.fromARGB(255, 101, 170, 238),
          title: Text('Filter Options',
              style: TextStyle(
                fontSize: 18,
              )),
          children: [
            CheckboxGroup(
              groupTitle: 'Status',
              options: states,
              selectedOptions: selectedStates,
              onChanged: (selected) {
                setState(() {
                  selectedStates = selected;
                  _getComplaints();
                });
              },
            ),
            Divider(
              endIndent: 15,
              indent: 15,
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            CheckboxGroup(
              groupTitle: 'complaint type',
              options: types,
              selectedOptions: selectedTypes,
              onChanged: (selected) {
                setState(() {
                  selectedTypes = selected;
                  _getComplaints();
                });
              },
            ),
            SizedBox(
              height: 10.v,
            ),
            Divider(
              endIndent: 15,
              indent: 15,
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            CheckboxGroup(
              groupTitle: 'severity',
              options: severities,
              selectedOptions: selectedSeverities,
              onChanged: (selected) {
                setState(() {
                  selectedSeverities = selected;
                  _getComplaints();
                });
              },
            ),
            SizedBox(
              height: 10.v,
            ),
          ],
        ));
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
