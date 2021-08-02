import 'package:flutter/material.dart';

class Crop {
  final String name;
  final String location;
  final String quantity;
  final String modalPrice;
  final String minPrice;
  final String maxPrice;
  final String updatedOn;

  Crop({
    @required this.name,
    @required this.location,
    @required this.quantity,
    @required this.modalPrice,
    @required this.minPrice,
    @required this.maxPrice,
    @required this.updatedOn,
  });

  factory Crop.fromJson(Map json) {
    return Crop(
      name: json['name'],
      location: json['location'],
      quantity: json['quantity'],
      modalPrice: json['modal_price'],
      minPrice: json['min_price'],
      maxPrice: json['max_price'],
      updatedOn: json['last_update'],
    );
  }
}
