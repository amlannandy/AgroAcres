import 'package:flutter/material.dart';

class Crop {
  final String name;
  final String variety;
  final String minPrice;
  final String maxPrice;
  final String modalPrice;
  final String state;
  final String district;
  final String arrivalDate;

  Crop({
    @required this.name,
    @required this.variety,
    @required this.minPrice,
    @required this.maxPrice,
    @required this.modalPrice,
    @required this.state,
    @required this.district,
    @required this.arrivalDate,
  });

  factory Crop.fromJson(Map crop) {
    return Crop(
      name: crop['commodity'],
      variety: crop['variety'],
      minPrice: crop['min_price'],
      maxPrice: crop['max_price'],
      modalPrice: crop['modal_price'],
      state: crop['state'],
      district: crop['district'],
      arrivalDate: crop['arrival_date'] ?? '10/10/10',
    );
  }
}
