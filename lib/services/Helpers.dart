import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpers {
  static void call(String phoneNumber) async {
    final url = 'tel:<$phoneNumber>';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: "Error opening contacts manager!");
    }
  }

  static Future<void> mapForDestination(
      double destinationLat, double destinationLong) async {
    final Position position = await Geolocator().getCurrentPosition();
    final pickupLat = position.latitude;
    final pickupLong = position.longitude;
    final url =
        'https://www.google.com/maps/dir/?api=1&origin=$pickupLat, $pickupLong&destination=$destinationLat,$destinationLong&travelmode=driving&dir_action=navigate';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(
        msg: "A problem has occured!",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
