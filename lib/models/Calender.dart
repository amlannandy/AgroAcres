import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Calender {

  final int harvestTime;
  final List timestamps;
  final List titles;
  final List subtitles;
  final List links;
  final List imageUrls;

  const Calender({
    @required this.timestamps,
    @required this.titles,
    @required this.subtitles,
    @required this.links,
    @required this.imageUrls,
    @required this.harvestTime,
  });

  factory Calender.fromFirestore(DocumentSnapshot snapshot) {
    final doc = snapshot.data;
    Calender calender = Calender(
      timestamps: doc['timestamps'] ?? [],
      titles: doc['titles'] ?? [],
      subtitles: doc['subtitles'] ?? [],
      links: doc['links'] ?? [],
      imageUrls: doc['imageUrls'] ?? [],
      harvestTime: doc['harvestTime'] ?? null,
    );
    return calender;
  }

}