import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {

  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final int quantity;
  final String quanityName;

  const Product({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.imageUrl,
    @required this.quantity,
    @required this.quanityName,
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
    );
    return product;
  }
}