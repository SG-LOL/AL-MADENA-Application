import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:majed_s_application2/core/app_export.dart';
import 'package:majed_s_application2/presentation/confirmation_screen/confirmation_screen.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:majed_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:majed_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:majed_s_application2/widgets/navbar.dart';
import 'package:requests/requests.dart';

class LocationOneScreen extends StatefulWidget {
  final String description;
  final String type;
  final List<String> base64Images;
  final Map<String, dynamic>? complaintInfo;
  LocationOneScreen(
      {Key? key,
      required this.description,
      required this.type,
      required this.base64Images,
      this.complaintInfo})
      : super(key: key);

  @override
  _LocationOneScreenState createState() => _LocationOneScreenState();
}

class _LocationOneScreenState extends State<LocationOneScreen> {
  late GoogleMapController googleMapController;
  late Position position;
  late String city;
  late String street;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(31.9539, 35.9106), zoom: 14);

  Set<Marker> markers = {};
  late LatLng _currentMarkerPosition;
  @override
  void initState() {
    super.initState();
    _currentMarkerPosition = initialCameraPosition.target;
    _setInitialCameraPosition();
  }

  void _setInitialCameraPosition() {
    if (widget.complaintInfo != null &&
        widget.complaintInfo!['location'] != null &&
        widget.complaintInfo!['location']['latitude'] != null &&
        widget.complaintInfo!['location']['longitude'] != null) {
      double latitude = widget.complaintInfo!['location']['latitude'];
      double longitude = widget.complaintInfo!['location']['longitude'];
      setState(() {
        _currentMarkerPosition = LatLng(latitude, longitude);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      endDrawer: Navebar(),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: _buildMarkers(),
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
        onTap: (LatLng latLng) {
          _updateMarkerPosition(latLng);
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () async {
              Position position = await _determinePosition();

              googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 14,
                  ),
                ),
              );

              setState(() {
                _currentMarkerPosition =
                    LatLng(position.latitude, position.longitude);
              });
            },
            label: const Text("Current Location"),
            icon: const Icon(Icons.location_history),
          ),
          SizedBox(height: 16.0),
          FloatingActionButton.extended(
            onPressed: () {
              if (widget.complaintInfo != null) {
                _updateComplaint();
              } else {
                _sendBase64Images();
              }
            },
            label: const Text("Submit The complaint"),
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        position: _currentMarkerPosition,
        draggable: false,
      ),
    );
    return markers;
  }

  void _updateMarkerPosition(LatLng newPosition) {
    setState(() {
      _currentMarkerPosition = newPosition;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    position = await Geolocator.getCurrentPosition();

    return position;
  }

  Future<void> _updateComplaint() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentMarkerPosition.latitude,
        _currentMarkerPosition.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;

        city = placemark.locality ?? '';
        street = placemark.street ?? '';
        if (widget.complaintInfo != null) {
          var response = await Requests.post(
            'http://10.0.2.2:5000/update_complaint',
            json: {
              'id': widget.complaintInfo!['complaint_id'],
              'images': widget.complaintInfo!['photos'],
              'type': widget.complaintInfo!['type'],
              'description': widget.complaintInfo!['description'],
              'city': city,
              'street': street,
              'latitude': _currentMarkerPosition.latitude,
              'longitude': _currentMarkerPosition.longitude,
            },
          );

          if (response.statusCode == 200) {
            onTapSubmit();
            print('Complaint successfully submitted.');
          }
        } else {
          print('Failed to send images and location information');
        }
      } else {
        print('No placemarks found');
      }
    } catch (error) {
      print('Error sending images and location information: $error');
    }
  }

  Future<void> _sendBase64Images() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentMarkerPosition.latitude,
        _currentMarkerPosition.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;

        city = placemark.locality ?? '';
        street = placemark.street ?? '';

        var response = await Requests.post(
          'http://10.0.2.2:5000/submit_complaint',
          json: {
            'images': widget.base64Images,
            'type': widget.type,
            'description': widget.description,
            'city': city,
            'street': street,
            'latitude': _currentMarkerPosition.latitude,
            'longitude': _currentMarkerPosition.longitude,
          },
        );

        if (response.statusCode == 200) {
          onTapSubmit();
          print('Complaint successfully submitted.');
        } else {
          print(
              'Failed to send images and location information. Status code: ${response.statusCode}');
        }
      } else {
        print('No placemarks found');
      }
    } catch (error) {
      print('Error sending images and location information: $error');
    }
  }

  void onTapSubmit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationScreen(),
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
}
