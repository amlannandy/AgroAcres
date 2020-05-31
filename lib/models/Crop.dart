import 'package:flutter/material.dart';

class Crop {

  final String id;
  final String name;
  final String imageUrl;
  final double price;

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

}