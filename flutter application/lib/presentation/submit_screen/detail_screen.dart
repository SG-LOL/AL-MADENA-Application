import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/location_one_screen/location_one_screen.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/custom_outlined_button.dart';
import 'package:majed_s_application2/widgets/custom_text_form_field.dart';
import 'package:majed_s_application2/widgets/navbar.dart';
import 'package:path_provider/path_provider.dart';

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic>? complaintInfo;
  final String complaintType;
  const DetailScreen(
      {Key? key, required this.complaintType, this.complaintInfo})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  TextEditingController descriptionController = TextEditingController();
  List<File> _selectedImages = [];
  List<String> base64Images = [];

  @override
  void initState() {
    super.initState();
    _initializeSelectedImages();
    _initializeDisc();
    _startTimer();
  }

  void _startTimer() {
    const duration = Duration(seconds: 3);
    Timer.periodic(duration, (timer) {
      setState(() {});
    });
  }

  void _initializeDisc() {
    if (widget.complaintInfo != null &&
        widget.complaintInfo!['description'] != null) {
      descriptionController.text = widget.complaintInfo!['description'];
    }
  }

  void _initializeSelectedImages() {
    if (widget.complaintInfo != null &&
        widget.complaintInfo!['photos'] != null) {
      List<dynamic> photos = widget.complaintInfo!['photos'];
      for (String base64Photo in photos) {
        Uint8List bytes = base64.decode(base64Photo);
        _saveImageToTemporaryFile(bytes);
      }
    }
  }

  Future<void> _saveImageToTemporaryFile(Uint8List bytes) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      String tempFilePath =
          '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png';
      File tempFile = File(tempFilePath);
      await tempFile.writeAsBytes(bytes);
      _selectedImages.add(tempFile);
    } catch (e) {
      print('Error saving image to temporary file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 51.v),
                CustomTextFormField(
                  controller: descriptionController,
                  readOnly: false,
                  hintText: "Describe your complaint ...",
                  hintStyle: CustomTextStyles.bodyLargeGray60001,
                  textInputAction: TextInputAction.done,
                  width: 350.h,
                  maxLines: 7,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8.h,
                    vertical: 15.v,
                  ),
                ),
                SizedBox(height: 50.v, width: 350.h),
                Padding(
                  padding: EdgeInsets.only(),
                  child: CustomOutlinedButton(
                    width: 350.h,
                    height: 86.v,
                    text: "Upload Pictures   ",
                    rightIcon: CustomImageView(
                      imagePath: ImageConstant.imgUpp1,
                      height: 39.v,
                      width: 44.h,
                    ),
                    buttonStyle: CustomButtonStyles.outlineOnError,
                    buttonTextStyle:
                        CustomTextStyles.titleLargeMontserratIndigoA700,
                    alignment: Alignment.topCenter,
                    onPressed: () async {
                      await _pickImagesAndSend();
                    },
                  ),
                ),
                SizedBox(height: 20.v),
                SizedBox(
                  height: 200.v,
                  child: _selectedImages.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _selectedImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(_selectedImages[index]),
                            );
                          },
                        )
                      : const Center(child: Text('No image selected')),
                ),
                SizedBox(height: 20.v),
                Padding(
                  padding: EdgeInsets.only(),
                  child: CustomOutlinedButton(
                    width: 350.h,
                    height: 86.v,
                    text: "Next",
                    buttonStyle: CustomButtonStyles.outlineOnError,
                    buttonTextStyle:
                        CustomTextStyles.titleLargeMontserratIndigoA700,
                    alignment: Alignment.topCenter,
                    onPressed: () {
                      if (widget.complaintInfo != null) {
                        widget.complaintInfo!['description'] =
                            descriptionController.text;
                        widget.complaintInfo!['photos'] = base64Images;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationOneScreen(
                                      description: descriptionController.text,
                                      type: widget.complaintType,
                                      base64Images: base64Images,
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationOneScreen(
                                      description: descriptionController.text,
                                      type: widget.complaintType,
                                      base64Images: base64Images,
                                    )));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
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

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> _pickImagesAndSend() async {
    try {
      List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
      _selectedImages.clear();

      for (XFile pickedFile in pickedFiles) {
        String base64Image = _convertImageToBase64(pickedFile.path);
        base64Images.add(base64Image);

        _selectedImages.add(File(pickedFile.path));
      }

      setState(() {});
    } catch (error) {
      print('Error picking and sending images: $error');
    }
  }

  String _convertImageToBase64(String imagePath) {
    List<int> imageBytes = File(imagePath).readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }
}
