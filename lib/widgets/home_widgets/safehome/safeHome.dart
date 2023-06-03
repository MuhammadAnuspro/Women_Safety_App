import 'package:background_sms/background_sms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:women_safety/Components/primaryButton.dart';
import 'package:women_safety/db/db_services.dart';
import 'package:women_safety/model/contacts.dart';
import 'package:women_safety/utils/constrins.dart';
import 'package:women_safety/Components/primaryButton.dart';

class SafeHome extends StatefulWidget {
  const SafeHome({super.key});

  @override
  State<SafeHome> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  //geoLocator dependance

  Position? _currentPosition;
  String? _currentAddress;
  LocationPermission? permission;

  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    SmsStatus result = await BackgroundSms.sendMessage(
      phoneNumber: phoneNumber,
      message: message,
      simSlot: simSlot,
    );
    (SmsStatus status) {
      if (result == SmsStatus.sent) {
        print('sent');

        Fluttertoast.showToast(msg: 'send');
      } else {
        Fluttertoast.showToast(msg: 'failed');
      }
    };
  }

  _getCurrentLocaton() async {
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      Fluttertoast.showToast(msg: 'Location permission  are denied');
      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(
            msg: 'Location permission are permanently denied ');
      }
    }
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print(_currentPosition!.latitude);
        _getAddressFromLatLon();
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.locality},${place.postalCode},${place.street},${place.country}";
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocaton();
    _getPermission();
  }

  showModelSafeHome(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipPath(
              clipper: RoundedDiagonalPathClipper(),
              child: Container(
                height: 360,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    color: Colors.blueGrey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 1,
                        blurRadius: 10,
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SEND YOUR LOCATION  IMEDIATELY TO YOU  EMERGENCY",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    if (_currentPosition != null)
                      Text(
                        _currentAddress!,
                        style: TextStyle(color: Colors.white),
                      ),
                    PrimaryButton(
                        title: 'GET LOCATION',
                        onPressed: () {
                          // _getCurrentLocaton();
                        }),
                    SizedBox(
                      height: 7,
                    ),
                    PrimaryButton(
                        title: 'SEND ALERT',
                        onPressed: () async {
                          List<TContacts> contactList =
                              await DatabaseHelper().getContactList();
                          String recipients = "";
                          int i = 1;
                          for (TContacts contact in contactList) {
                            recipients += contact.number;
                            if (i != contactList.length) {
                              recipients += ";";
                              i++;
                            }
                          }
                          String massageBody =
                              "https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}. $_currentAddress";
                          if (await _isPermissionGranted()) {
                            contactList.forEach((element) {
                              _sendSms('${element.number}',
                                  "i am in trouble $massageBody",
                                  simSlot: 2);
                            });
                            return Fluttertoast.showToast(
                                msg: 'Location Send Succsusfully ',
                                backgroundColor: primaryColor);
                          } else {
                            Fluttertoast.showToast(msg: 'Something is wrong');
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModelSafeHome(context),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 170,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Send Location"),
                        subtitle: Text(
                          "Share Location",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/helpme.jpg",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
