import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import '../models/User.dart';

class UserDatabaseService {
  
  final Firestore _db = Firestore.instance;

  Stream<User> streamUser(String id) {
    return _db.collection('users').document(id).snapshots().map(
      (snapshot) => User.fromFirestore(snapshot)
    );
  }

  Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _db.collection('users').document(id).get();
    print(snapshot.data);
    return User.fromFirestore(snapshot);
  }
  
}