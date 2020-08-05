import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopProvider {
  static Firestore _db = Firestore.instance;

  static void addProduct(BuildContext context,
      {String title,
      String price,
      String quantity,
      String quantityName,
      String imageUrl,
      Position position}) async {
    if (title.isEmpty ||
        price.isEmpty ||
        quantity.isEmpty ||
        quantityName.isEmpty ||
        position == null) {
      return;
    }
    try {
      double.parse(price);
      int.parse(quantity);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Please enter a valid value",
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _db.collection('products').document().setData({
      'title': title,
      'price': double.parse(price),
      'quantity': int.parse(quantity),
      'quantityName': quantityName,
      'userId': user.uid,
      'imageUrl': imageUrl,
      'phoneNumber': user.phoneNumber,
      'position': GeoPoint(position.latitude, position.longitude),
    });
    Fluttertoast.showToast(
        msg: "Product created!",
        backgroundColor: Colors.green,
        textColor: Colors.white);
    Navigator.of(context).pop();
  }

  static void editProduct(BuildContext context, String productId,
      {String title,
      String price,
      String quantity,
      String quantityName,
      String imageUrl,
      Position position}) {
    if (title.isEmpty ||
        price.isEmpty ||
        quantity.isEmpty ||
        quantityName.isEmpty ||
        imageUrl.isEmpty ||
        position == null) {
      return;
    }
    try {
      double.parse(price);
      int.parse(quantity);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Please enter a valid value",
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
    _db.collection('products').document(productId).updateData({
      'title': title,
      'price': double.parse(price),
      'quantity': int.parse(quantity),
      'quantityName': quantityName,
      'imageUrl': imageUrl,
      'position': GeoPoint(position.latitude, position.longitude),
    });
    Fluttertoast.showToast(
        msg: "Product updated!",
        backgroundColor: Colors.green,
        textColor: Colors.white);
    Navigator.of(context).pop();
  }

  static void deleteProduct(String productId, bool isEnglish) {
    _db.collection('products').document(productId).delete();
    Fluttertoast.showToast(
        msg: isEnglish ? "Product deleted" : "उत्पाद हटा दिया गया");
  }

  static void deleteProductConfirmation(
      BuildContext context, String productId, bool isEnglish) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                isEnglish ? 'Confirmation' : 'पुष्टीकरण',
                style: TextStyle(color: Colors.black, fontFamily: 'Lato'),
              ),
              content: Text(
                isEnglish
                    ? 'Are you sure you want to delete this product?'
                    : 'क्या आप वाकई इस उत्पाद को हटाना चाहते हैं?',
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
                    deleteProduct(productId, isEnglish);
                    Navigator.of(context).pop();
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

  static void callSeller(String phoneNumber) async {
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
          textColor: Colors.white);
    }
  }
}
