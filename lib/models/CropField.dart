import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CropField {

  final String id;
  final String crop;
  final Position position;
  final Timestamp startDate;
  final String imageUrl;
  final String startTime;
  final int harvestTime;

  const CropField({
    @required this.id,
    @required this.crop,
    @required this.position,
    @required this.startDate,
    @required this.startTime,
    @required this.imageUrl,
    @required this.harvestTime,
  });

  factory CropField.fromFirestore(DocumentSnapshot snapshot) {
    final doc = snapshot.data;
    final field = CropField(
      id: snapshot.documentID,
      crop: doc['crop'] ?? null,
      position: Position(latitude: doc['position'].latitude, longitude: doc['position'].longitude) ?? null,
      startDate: doc['startDate'] ?? null,
      startTime: doc['startTime'] ?? null,
      imageUrl: doc['imageUrl'] ?? null,
      harvestTime: doc['harvestTime'] ?? null,
    );
    return field;
  }

}