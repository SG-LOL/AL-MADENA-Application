import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/welcome_screen/welcome_screen.dart';
import 'package:majed_s_application2/services/ministry_services.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';
import 'package:majed_s_application2/widgets/navbar.dart';
import 'package:requests/requests.dart';

class MinistryInformationScreen extends StatefulWidget {
  final String ministryId;
  final bool isItVisible;

  MinistryInformationScreen(
      {Key? key, required this.ministryId, required this.isItVisible})
      : super(key: key);

  @override
  _MinistryInformationScreenState createState() =>
      _MinistryInformationScreenState();
}

class _MinistryInformationScreenState extends State<MinistryInformationScreen> {
  late MediaQueryData mediaQueryData;

  Map<String, dynamic> ministryInfo = {};

  @override
  void initState() {
    super.initState();
    _getMinistry(widget.ministryId);
  }

  Future<void> _getMinistry(String ministryId) async {
    try {
      final ministryrData = await fetchMinistry(ministryId);
      setState(() {
        ministryInfo = ministryrData;
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
    if (ministryInfo.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return MinistryCard(
        ministry: ministryInfo,
        isItVisible: widget.isItVisible,
      );
    }
  }
}

class MinistryCard extends StatelessWidget {
  Future<bool> confirmMinistry(String ministryId) async {
    try {
      final response = await Requests.get(
          'http://10.0.2.2:5000/confirm_ministry/$ministryId');

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        print(data['message']);
        return true;
      } else {
        print(
            'Failed to confirm ministry. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }

  Future<bool> sendDeclineEmail(String email) async {
    try {
      final response = await Requests.post(
          'http://10.0.2.2:5000/send_decline_email',
          body: {'email': email});

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  final Map<String, dynamic> ministry;
  final bool isItVisible;

  MinistryCard({required this.ministry, required this.isItVisible});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 16.0),
      _buildCard('ID', ' ${ministry['id']}'),
      _buildCard('ministry name', '${ministry['ministry_name']}'),
      _buildCard('phone number', '${ministry['phone_number']}'),
      _buildCard('email', '${ministry['email']}'),
      _buildCard('city', '${ministry['city']}'),
      _buildCard('responsibilities', '${ministry['resp']}'),
      _buildButtonCard(
          isItVisible, ' ${ministry['id']}', '${ministry['email']}', context)
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

  Widget _buildButtonCard(
      bool isItVisible, String id, String email, BuildContext context) {
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
                  text: "deny request",
                  buttonStyle: CustomButtonStyles.outlineOnError,
                  buttonTextStyle:
                      CustomTextStyles.titleLargeMontserratIndigoA700,
                  alignment: Alignment.topCenter,
                  onPressed: () {
                    sendDeclineEmail(email);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()));
                  }),
              SizedBox(height: 16.0),
              CustomOutlinedButton(
                width: 315.h,
                text: "approve request",
                buttonStyle: CustomButtonStyles.outlineOnError,
                buttonTextStyle:
                    CustomTextStyles.titleLargeMontserratIndigoA700,
                alignment: Alignment.topCenter,
                onPressed: () {
                  confirmMinistry(id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
