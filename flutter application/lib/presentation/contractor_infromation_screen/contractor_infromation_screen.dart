import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/navbar.dart';
import 'package:majed_s_application2/services/contractor_services.dart';

class ContractorInformationScreen extends StatefulWidget {
  final String contractorId;

  final bool isItVisible;

  ContractorInformationScreen(
      {Key? key, required this.contractorId, required this.isItVisible})
      : super(key: key);

  @override
  _ContractorInformationScreenState createState() =>
      _ContractorInformationScreenState();
}

class _ContractorInformationScreenState
    extends State<ContractorInformationScreen> {
  late MediaQueryData mediaQueryData;

  Map<String, dynamic> contractorInfo = {};

  @override
  void initState() {
    super.initState();
    _getContractor(widget.contractorId);
  }

  Future<void> _getContractor(String contractorId) async {
    try {
      final contractorData = await fetchContractor(contractorId);
      setState(() {
        contractorInfo = contractorData;
      });
    } catch (error) {
      print('Error: $error');
    }
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

  Widget _buildBody() {
    if (contractorInfo.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ContractorCard(
        contractor: contractorInfo,
      );
    }
  }
}

class ContractorCard extends StatelessWidget {
  final Map<String, dynamic> contractor;

  ContractorCard({required this.contractor});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 16.0),
      _buildCard('ID', ' ${contractor['id']}'),
      _buildCard('company name', '${contractor['company_name']}'),
      _buildCard('phone number', '${contractor['phone_number']}'),
      _buildCard('email', '${contractor['email']}'),
      _buildCard('city', '${contractor['contractor_city']}'),
      _buildCard('specialty', '${contractor['specialty']}')
    ]);
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
}
