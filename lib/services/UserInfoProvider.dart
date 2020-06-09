import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoProvider {

  static File currentImage;
  static String currentImageUrl = "";

  static void uploadUserInfo({BuildContext context, String name, String age, String location, String aadharNumber, Position userPosition}) async {
    if (name.isEmpty || age.isEmpty || location.isEmpty || aadharNumber.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill up all the fields");
      return;
    }
    if (age.length != 2) {
      Fluttertoast.showToast(msg: "Please enter a valid age");
      return;
    }
    try {
      int newAge = int.parse(age);
      if (newAge < 18) {
        Fluttertoast.showToast(msg: "Please enter a valid age");
        return;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Please enter a valid age");
    }
    if (aadharNumber.length != 12) {
      Fluttertoast.showToast(msg: "Please enter a 12 digit Aadhar Card Number");
      return;
    }
    if (userPosition == null) {
      userPosition = Position(latitude: 23, longitude: 87);
    }
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('users').document(user.uid).setData({
      'name' : name,
      'age' : int.parse(age),
      'phone' : user.phoneNumber,
      'city' : location,
      'imageUrl' : currentImageUrl.isEmpty ? "https://firebasestorage.googleapis.com/v0/b/agroacres-bbsr.appspot.com/o/user_profile_photos%2Fdefault.png?alt=media&token=bce57e61-72f5-4a9e-a211-c40523912169" : currentImageUrl,
      'location' : GeoPoint(userPosition.latitude, userPosition.longitude),
      'aadharNumber' : aadharNumber,
    });
    Navigator.of(context).pushReplacementNamed('/init');
  }

  static Future takePicture(BuildContext context, Function notifyChanges) async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null)
      return;
    currentImage = imageFile;
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('doctorProfilePictures/${Path.basename(currentImage.path)}}');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(currentImage);
    await uploadTask.onComplete;
    firebaseStorageRef.getDownloadURL().then((fileUrl) {
      currentImageUrl = fileUrl;
      notifyChanges();
    });
  }

  static Future uploadPicture(BuildContext context, Function notifyChanges) async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null)
      return;
    currentImage = imageFile;
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('doctorProfilePictures/${Path.basename(currentImage.path)}}');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(currentImage);
    await uploadTask.onComplete;
    firebaseStorageRef.getDownloadURL().then((fileUrl) {
      currentImageUrl = fileUrl;
      notifyChanges();
    });
  }

  static Future<void> logOut(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/init');
  }

}