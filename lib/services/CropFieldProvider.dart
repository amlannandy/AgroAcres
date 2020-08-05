import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/CalenderScreen/local_widgets/CropDropdownList.dart';

class CropFieldProvider {
  static final _db = Firestore.instance;
  static final _auth = FirebaseAuth.instance;

  static String getFormattedDate(Timestamp timestamp) {
    return DateFormat('dd-MM-yyyy').format(timestamp.toDate()).toString();
  }

  static String getFormattedDatePlusDays(Timestamp timestamp, int days) {
    DateTime dateTime = timestamp.toDate();
    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day + days);
    Timestamp newTimestamp = Timestamp.fromDate(dateTime);
    return DateFormat('dd-MM-yyyy').format(newTimestamp.toDate()).toString();
  }

  static showDateChooser(
      BuildContext context, Function getValues, Function setController) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (date != null) {
      Timestamp timestamp = Timestamp.fromDate(date);
      String dateString = getFormattedDate(timestamp);
      getValues(timestamp, dateString);
      setController(dateString);
    }
  }

  static showCropDropdown(BuildContext context, Function selectValues) {
    showDialog(
      context: context,
      child: CropDropdownList(selectValues),
    );
  }

  static uploadCropField(
      {BuildContext context,
      String cropName,
      String startDate,
      Timestamp startTimestamp,
      Position position,
      String imageUrl}) async {
    if (cropName.isEmpty ||
        startTimestamp == null ||
        position == null ||
        imageUrl.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill all data');
      return;
    }
    String fieldId = _db.collection('cropfields').document().documentID;
    FirebaseUser user = await _auth.currentUser();
    _db.collection('users').document(user.uid).updateData({
      'fieldId': fieldId,
    });
    DocumentSnapshot snapshot =
        await _db.collection('cropData').document(cropName).get();
    int harvestTime = snapshot['harvestTime'];
    _db.collection('cropfields').document(fieldId).setData({
      'crop': cropName,
      'startDate': startTimestamp,
      'position': GeoPoint(position.latitude, position.longitude),
      'startTime': startDate,
      'userId': user.uid,
      'imageUrl': imageUrl,
      'harvestTime': harvestTime,
    });
    Fluttertoast.showToast(
        msg: 'Crop Field uploaded',
        backgroundColor: Colors.green,
        textColor: Colors.white);
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed('/field');
  }

  static deleteCropField(BuildContext context, String fieldId) async {
    _db.collection('cropfields').document(fieldId).delete();
    FirebaseUser user = await _auth.currentUser();
    _db.collection('users').document(user.uid).updateData({
      'fieldId': null,
    });
    Fluttertoast.showToast(msg: "Product deleted");
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  static void deleteCropFieldConfirmation(
      BuildContext context, String fieldId, bool isEnglish) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                isEnglish ? 'Confirmation' : 'पुष्टीकरण',
                style: TextStyle(color: Colors.black, fontFamily: 'Lato'),
              ),
              content: Text(
                isEnglish
                    ? 'Are you sure you want to delete your field?'
                    : 'क्या आप वाकई अपना फ़ील्ड हटाना चाहते हैं?',
                style: TextStyle(color: Colors.black, fontFamily: 'Lato'),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    isEnglish ? 'No' : 'नहीं',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    deleteCropField(context, fieldId);
                  },
                  child: Text(
                    isEnglish ? 'Yes' : 'हाँ',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ));
  }
}
