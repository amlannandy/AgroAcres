import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  String userId;
  final String title;
  final double price;
  String imageUrl;
  final int quantity;
  final String quanityName;
  String phoneNumber;
  final Position position;

  Product({
    this.id,
    this.userId,
    @required this.title,
    @required this.price,
    this.imageUrl,
    @required this.quantity,
    @required this.quanityName,
    this.phoneNumber,
    @required this.position,
  });

  factory Product.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    if (data == null) {
      return null;
    }
    Product product = Product(
      id: snapshot.documentID,
      title: data['title'] ?? null,
      price: data['price'] ?? null,
      imageUrl: data['imageUrl'] ?? null,
      quantity: data['quantity'] ?? null,
      quanityName: data['quantityName'] ?? null,
      phoneNumber: data['phoneNumber'] ?? null,
      position: Position(
              latitude: data['position'].latitude,
              longitude: data['position'].longitude) ??
          null,
    );
    return product;
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': this.userId,
      'title': this.title,
      'price': this.price,
      'imageUrl': this.imageUrl,
      'quantity': this.quantity,
      'quantityName': this.quanityName,
      'phoneNumber': this.phoneNumber,
      'position': GeoPoint(
        this.position.latitude,
        this.position.longitude,
      ),
    };
  }
}
