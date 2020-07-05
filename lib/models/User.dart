import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class User {

  final String userId;
  final String name;
  final int age;
  final String phone;
  final String imageUrl;
  final String city;
  final Position location;
  final String aadharNo;
  final String fieldId;

  User({
    this.userId,
    this.name,
    this.age,
    this.phone,
    this.city,
    this.aadharNo,
    this.location,
    this.imageUrl,
    this.fieldId,
  });

  factory User.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    if (data == null)
      return null;
    User user = User(
      userId: snapshot.documentID,
      name: data['name'] ?? null,
      age: data['age'] ?? null,
      phone: data['phone'] ?? null,
      city: data['city'] ?? null,
      aadharNo: data['aadharNumber'] ?? null,
      imageUrl: data['imageUrl'] ?? "https://firebasestorage.googleapis.com/v0/b/agroacres-bbsr.appspot.com/o/user_profile_photos%2Fdefault.png?alt=media&token=bce57e61-72f5-4a9e-a211-c40523912169",
      location: Position(
        latitude: data['location'].latitude,
        longitude: data['location'].longitude,
      ) ?? null,
      fieldId: data['fieldId'] ?? null,
    );
    return user;
  }

}