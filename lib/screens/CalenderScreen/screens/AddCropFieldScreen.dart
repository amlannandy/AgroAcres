import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../local_widgets/DateField.dart';
import '../local_widgets/ImageInput.dart';
import '../local_widgets/CustomAppBar.dart';
import '../../../widgets/PrimaryButton.dart';
import '../local_widgets/Locationinput.dart';
import '../local_widgets/CropDropdownField.dart';
import '../../../services/CropFieldProvider.dart';

class AddCropFieldScreen extends StatefulWidget {

  @override
  _AddCropFieldScreenState createState() => _AddCropFieldScreenState();
}

class _AddCropFieldScreenState extends State<AddCropFieldScreen> {
  
  String _cropName = "";
  String _startTimeString = "";
  Timestamp _startTimeStamp;
  Position _position;
  String _imageUrl = "";
  File _image;

  void setCropName(String crop) {
    _cropName = crop;
  }

  void setTimeValues(Timestamp timestamp, String date) {
    _startTimeStamp = timestamp;
    _startTimeString = date;
  }

  void selectLocation(double lat, double long) {
    _position = Position(latitude: lat, longitude: long);
  }

  void selectImage(File image) async {
    setState(() {
      _image = image;
    });
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('shopPictures/${Path.basename(image.path)}}');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    await uploadTask.onComplete;
    firebaseStorageRef.getDownloadURL().then((fileUrl) {
      _imageUrl = fileUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Add Crop Field'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CropDropdownField(setCropName),
            DateField(setTimeValues),
            ImageInput(selectImage),
            LocationInput(selectLocation),
            PrimaryButton(
              text: 'SUBMIT',
              press: () => CropFieldProvider.uploadCropField(
                context: context,
                cropName: _cropName,
                startTimestamp: _startTimeStamp,
                startDate: _startTimeString,
                position: _position,
                imageUrl: _imageUrl,
              ),
              color: Colors.green[800]
            ),
          ],
        ),
      ),
    );
  }
}