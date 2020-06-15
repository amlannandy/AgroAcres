import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Crop {

  final String id;
  final String name;
  final String imageUrl;
  final int price;

  Crop({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.price,
  });

  factory Crop.fromJson(Map crop) {
    return Crop(
      id: crop['id'],
      name: crop['name'],
      imageUrl: crop['imageUrl'],
      price: crop['price'],
    );
  }

  factory Crop.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    if (data == null)
      return null;
    Crop user = Crop(
      id: snapshot.documentID,
      name: data['name'],
      imageUrl: data['imageUrl'],
      price: data['price'],
    );
    return user;
  }

}