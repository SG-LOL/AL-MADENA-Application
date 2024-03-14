import 'package:flutter/material.dart';
import 'package:majed_s_application2/presentation/admin_screen/admin_screen.dart';
import 'package:majed_s_application2/presentation/complaint_info_reviewer_screen/complaint_info_reviewer_screen.dart';
import 'package:majed_s_application2/presentation/contractor_application_screen/contractor_application_screen.dart';
import 'package:majed_s_application2/presentation/contractor_complaint_info_screen/contractor_complaint_info_screen.dart';
import 'package:majed_s_application2/presentation/contractor_complaint_list_screen/contractor_complaint_list_screen.dart';
import 'package:majed_s_application2/presentation/contractor_infromation_screen/contractor_infromation_screen.dart';
import 'package:majed_s_application2/presentation/contractor_screen/contractor_screen.dart';
import 'package:majed_s_application2/presentation/create_admin_screen/create_admin_screen.dart';
import 'package:majed_s_application2/presentation/create_reviewer_screen/create_reviewer_screen.dart';
import 'package:majed_s_application2/presentation/ministry_application_list/ministry_application_list.dart';
import 'package:majed_s_application2/presentation/ministry_application_screen/ministry_application_screen.dart';
import 'package:majed_s_application2/presentation/ministry_complaint_info_screen/ministry_complaint_info_screen.dart';
import 'package:majed_s_application2/presentation/ministry_complaint_list_screen/ministry_complaint_list_screen.dart';
import 'package:majed_s_application2/presentation/ministry_confirmation_screen/ministry_confirmation_screen.dart';
import 'package:majed_s_application2/presentation/ministry_information_screen/ministry_information_screen.dart';
import 'package:majed_s_application2/presentation/recover_account_screen/recover_account_acreen.dart';
import 'package:majed_s_application2/presentation/reviewer_complaint_list_screen/reviewer_complaint_list_screen.dart';
import 'package:majed_s_application2/presentation/reviewer_screen/reviewer_screen.dart';
import 'package:majed_s_application2/presentation/welcome_screen/welcome_screen.dart';
import 'package:majed_s_application2/presentation/logo_screen/logo_screen.dart';
import 'package:majed_s_application2/presentation/language_screen/language_screen.dart';
import 'package:majed_s_application2/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:majed_s_application2/presentation/otp_one_screen/otp_one_screen.dart';
import 'package:majed_s_application2/presentation/otp_screen/otp_screen.dart';
import 'package:majed_s_application2/presentation/create_profile_screen/create_profile_screen.dart';
import 'package:majed_s_application2/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:majed_s_application2/presentation/location_one_screen/location_one_screen.dart';
import 'package:majed_s_application2/presentation/type_screen/type_screen.dart';
import 'package:majed_s_application2/presentation/submit_screen/detail_screen.dart';
import 'package:majed_s_application2/presentation/confirmation_screen/confirmation_screen.dart';
import 'package:majed_s_application2/presentation/complaint_list_screen/complaint_list_screen.dart';
import 'package:majed_s_application2/presentation/complaint_listone_screen/complaint_listone_screen.dart';
import 'package:majed_s_application2/presentation/profile_screen/profile_screen.dart';
import 'package:majed_s_application2/presentation/change_password_screen/change_password_screen.dart';
import 'package:majed_s_application2/presentation/notification_screen/notification_screen.dart';

class AppRoutes {
  static const String welcomeScreen = '/welcome_screen';

  static const String logoScreen = '/logo_screen';

  static const String adminScreen = '/admin_screen';

  static const String createAdmin = '/create_admin_screen';

  static const String createReviewer = '/create_reviewer_screen';

  static const String reviewerScreen = '/reviewer_screen';

  static const String contractorScreen = '/contractor_screen';

  static const String reviewerComplaintListScreen =
      '/reviewer_complaint_list_screen';

  static const String complaintInforeviewerScreen =
      '/complaint_info_reviewer_screen';

  static const String ministryComplaintListScreen =
      '/ministry_complaint_list_screen';
  static const String ministryComplaintInfoScreen =
      '/ministry_complaint_Info_screen';
  static const String ministryApplication = '/ministry_application_screen';

  static const String ministryInformation = '/ministry_information_screen';

  static const String ministryConfirmation = '/ministry_confirmation_screen';

  static const String ministryApplicationList =
      '/ministry_application_list_screen';

  static const String languageScreen = '/language_screen';

  static const String contractorApplication = '/contractor_application_screen';

  static const String contractorComplaintListScreen =
      '/contractor_complaint_list_screen';
  static const String contractorComplaintInfoScreen =
      '/contractor_complaint_Info_screen';

  static const String contactorInformation = '/contractor_information_screen';

  static const String signUpScreen = '/sign_up_screen';

  static const String otpOneScreen = '/otp_one_screen';

  static const String otpScreen = '/otp_screen';

  static const String createProfileScreen = '/create_profile_screen';

  static const String signInScreen = '/sign_in_screen';

  static const String locationOneScreen = '/location_one_screen';

  static const String typeScreen = '/type_screen';

  static const String submitScreen = '/submit_screen';

  static const String confirmationScreen = '/confirmation_screen';

  static const String settingScreen = '/setting_screen';

  static const String complaintListScreen = '/complaint_list_screen';

  static const String complaintListoneScreen = '/complaint_listone_screen';

  static const String profileScreen = '/profile_screen';

  static const String changePasswordScreen = '/change_password_screen';

  static const String notificationScreen = '/notification_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String recoverAccount = '/recover_aacount';

  static Map<String, WidgetBuilder> routes = {
    welcomeScreen: (context) => WelcomeScreen(),
    logoScreen: (context) => LogoScreen(),
    languageScreen: (context) => LanguageScreen(),
    signUpScreen: (context) => SignUpScreen(),
    otpOneScreen: (context) => OtpOneScreen(
          email: '',
        ),
    otpScreen: (context) => OtpScreen(),
    createProfileScreen: (context) => CreateProfileScreen(),
    signInScreen: (context) => SignInScreen(),
    locationOneScreen: (context) => LocationOneScreen(
          description: '',
          type: '',
          base64Images: [],
        ),
    typeScreen: (context) => TypeScreen(),
    submitScreen: (context) => DetailScreen(
          complaintType: '',
        ),
    confirmationScreen: (context) => ConfirmationScreen(),
    complaintListScreen: (context) => ComplaintListScreen(),
    complaintListoneScreen: (context) => ComplaintListoneScreen(
          complaintId: '',
        ),
    profileScreen: (context) => ProfileScreen(),
    changePasswordScreen: (context) => ChangePasswordScreen(),
    notificationScreen: (context) => NotificationScreen(),
    recoverAccount: (context) => RecoverAccount(),
    adminScreen: (context) => AdminScreen(),
    createAdmin: (context) => CreateAdmin(),
    createReviewer: (context) => CreateReviewer(),
    reviewerScreen: (context) => ReviewerScreen(),
    reviewerComplaintListScreen: (context) => ReviewerComplaintListScreen(),
    complaintInforeviewerScreen: (context) =>
        CompalintInfoReviewer(complaintId: ''),
    ministryComplaintListScreen: (context) => MinistryComplaintListScreen(),
    ministryComplaintInfoScreen: (context) =>
        MinistryCompalintInfoScreen(complaintId: ''),
    ministryApplication: (context) => MinistryApplication(),
    ministryApplicationList: (context) => MinistryApplicationList(),
    ministryConfirmation: (context) => MinistryConfirmationScreen(),
    ministryInformation: (context) => MinistryInformationScreen(
          ministryId: '',
          isItVisible: false,
        ),
    contractorApplication: (context) => ContractorApplication(),
    contractorScreen: (context) => ContractorScreen(),
    contractorComplaintListScreen: (context) => ContractorComplaintListScreen(),
    contractorComplaintInfoScreen: (context) =>
        ContractorCompalintInfoScreen(complaintId: ''),
    contactorInformation: (context) => ContractorInformationScreen(
          contractorId: '',
          isItVisible: false,
        ),
  };
}
