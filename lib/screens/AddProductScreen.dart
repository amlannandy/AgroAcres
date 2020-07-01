import 'dart:io';
import 'package:AgroAcres/models/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/ImageInput.dart';
import '../services/ShopProvider.dart';
import '../widgets/CustomDarkButton.dart';
import '../widgets/CustomTextField.dart';

class AddProductScreen extends StatefulWidget {

  final String productId;

  const AddProductScreen({ this.productId });

  @override
  _AddProductScreenState createState() => _AddProductScreenState();

}

class _AddProductScreenState extends State<AddProductScreen> {

  final _db = Firestore.instance;

  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _quantityNameController = TextEditingController();

  File imageFile;
  String imageUrl = "";

  @override
  void initState() {
    if (widget.productId != null) {
      fetchExistingValues();
    }
    super.initState();
  }

  void selectImage(File image) async {
    setState(() {
      imageFile = image;
    });
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('products/${Path.basename(image.path)}}');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    await uploadTask.onComplete;
    firebaseStorageRef.getDownloadURL().then((fileUrl) {
      imageUrl = fileUrl;
    });
  }

  void fetchExistingValues() async {
    DocumentSnapshot doc = await _db.collection('products').document(widget.productId).get();
    Product product = Product.fromFirestore(doc);
    setState(() {
      _titleController.text = product.title;
      _priceController.text = product.price.toString();
      _quantityController.text = product.quantity.toString();
      _quantityNameController.text = product.quanityName;
      imageUrl = product.imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        widget.productId == null ? 'Add Product' : 'Edit Product',
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            CustomTextField(
              controller: _titleController,
              icon: FontAwesomeIcons.boxTissue,
              labelText: 'Name of Product',
            ),
            ImageInput(
              selectImage,
              imageUrl: imageUrl,
            ),
            CustomTextField(
              controller: _priceController,
              icon: FontAwesomeIcons.rupeeSign,
              labelText: 'Price per Item',
              numeric: true,
            ),
            CustomTextField(
              controller: _quantityController,
              icon: FontAwesomeIcons.sortNumericUp,
              labelText: 'Quantity',
              numeric: true,
            ),
            CustomTextField(
              controller: _quantityNameController,
              icon: FontAwesomeIcons.weightHanging,
              labelText: 'Unit of Quantity',
            ),
            SizedBox(height: 20),
            customDarkButton(
              text: 'CONFIRM',
              icon: FontAwesomeIcons.checkCircle,
              onPress: widget.productId == null ? () => ShopProvider.addProduct(
                context,
                title: _titleController.text,
                price: _priceController.text,
                quantity: _quantityController.text,
                quantityName: _quantityNameController.text,
                imageUrl: imageUrl,
              ) : () => ShopProvider.editProduct(
                context, 
                widget.productId,
                title: _titleController.text,
                price: _priceController.text,
                quantity: _quantityController.text,
                quantityName: _quantityNameController.text,
                imageUrl: imageUrl,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar(BuildContext context, String title) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 22,
          color: Colors.black.withOpacity(0.8),
          fontWeight: FontWeight.bold
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black.withOpacity(0.8),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}