import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/User.dart';
import '../models/Product.dart';

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

  Stream<Product> streamProduct(String id) {
    return _db.collection('products').document(id).snapshots().map(
      (snapshot) => Product.fromFirestore(snapshot)
    );
  }

  Future<Product> getProduct(String id) async {
    DocumentSnapshot snapshot = await _db.collection('products').document(id).get();
    print(snapshot.data);
    return Product.fromFirestore(snapshot);
  }
  
}