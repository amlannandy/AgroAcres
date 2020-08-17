import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Tutorial {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String videoUrl;

  const Tutorial({
    @required this.id,
    @required this.title,
    @required this.subtitle,
    @required this.imageUrl,
    @required this.videoUrl,
  });

  factory Tutorial.fromFirestore(DocumentSnapshot snapshot) {
    final doc = snapshot.data;
    final field = Tutorial(
      id: snapshot.documentID,
      title: doc['title'] ?? null,
      subtitle: doc['subtitle'] ?? null,
      imageUrl: doc['imageUrl'] ?? null,
      videoUrl: doc['videoUrl'] ?? null,
    );
    return field;
  }
}
