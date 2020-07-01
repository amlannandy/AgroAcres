import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopProvider {

  static Firestore _db = Firestore.instance;

  static void addProduct(BuildContext context, { String title, String price, String quantity, String quantityName, String imageUrl }) async {
    if (title.isEmpty || price.isEmpty || quantity.isEmpty || quantityName.isEmpty) {
      return;
    }
    try {
      double.parse(price);
      int.parse(quantity);
    } catch (e) {
      Fluttertoast.showToast(msg: "Please enter a valid value", backgroundColor: Colors.red, textColor: Colors.white);
    }
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _db.collection('products').document().setData({
      'title' : title,
      'price' : double.parse(price),
      'quantity' : int.parse(quantity),
      'quantityName' : quantityName,
      'userId' : user.uid,
      'imageUrl' : imageUrl,
    });
    Fluttertoast.showToast(msg: "Product created!", backgroundColor: Colors.green, textColor: Colors.white);
    Navigator.of(context).pop();
  }

  static void editProduct(BuildContext context, String productId, { String title, String price, String quantity, String quantityName, String imageUrl }) {
    if (title.isEmpty || price.isEmpty || quantity.isEmpty || quantityName.isEmpty || imageUrl.isEmpty) {
      return;
    }
    try {
      double.parse(price);
      int.parse(quantity);
    } catch (e) {
      Fluttertoast.showToast(msg: "Please enter a valid value", backgroundColor: Colors.red, textColor: Colors.white);
    }
    _db.collection('products').document(productId).updateData({
      'title' : title,
      'price' : double.parse(price),
      'quantity' : int.parse(quantity),
      'quantityName' : quantityName,
      'imageUrl' : imageUrl,
    });
    Fluttertoast.showToast(msg: "Product updated!", backgroundColor: Colors.green, textColor: Colors.white);
    Navigator.of(context).pop();
  }

  static void deleteProduct(String productId) {
    _db.collection('products').document(productId).delete();
    Fluttertoast.showToast(msg: "Product deleted");
  }

  static void deleteProductConfirmation(BuildContext context, String productId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Confirmation',
          style: TextStyle(color: Colors.black, fontFamily: 'Lato'),
        ),
        content: Text(
          'Are you sure you want to delete this product',
          style: TextStyle(color: Colors.black, fontFamily: 'Lato'),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'No',
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
              deleteProduct(productId);
              Navigator.of(context).pop();
            },
            child: Text('Yes',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      )
    );
  }

}