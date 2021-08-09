import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import './ProductsState.dart';
import '../../../models/Product.dart';

class ProductsBloc {
  bool userOnly;
  String userId;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _db = Firestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  ProductsBloc({String userId, bool fetchProducts = true, String productId}) {
    if (fetchProducts && userId != null) {
      _fetchUserProducts(userId);
      this.userOnly = true;
    } else if (fetchProducts) {
      _fetchAllProducts();
      this.userOnly = false;
    }
  }

  StreamController<ProductsState> _stateController =
      StreamController<ProductsState>.broadcast();

  _fetchAllProducts() async {
    try {
      final res = await _db.collection('products').getDocuments();
      List<Product> products = [];
      res.documents.forEach((doc) => products.add(Product.fromFirestore(doc)));
      _setState(ProductsState.onSuccess(products));
    } catch (e) {
      _setState(ProductsState.onError(e.message));
    }
  }

  _fetchUserProducts(String userId) async {
    try {
      this.userId = userId;
      final res = await _db
          .collection('products')
          .where('userId', isEqualTo: this.userId)
          .getDocuments();
      List<Product> userProducts = [];
      res.documents
          .forEach((doc) => userProducts.add(Product.fromFirestore(doc)));
      _setState(ProductsState.onSuccess(userProducts));
    } catch (e) {
      _setState(ProductsState.onError(e.message));
    }
  }

  fetchProduct(String id, Function callback) async {
    try {
      final res = await _db.collection('products').document(id).get();
      final product = Product.fromFirestore(res);
      callback(product);
      _setState(ProductsState.onProductSuccess());
    } catch (e) {
      _setState(ProductsState.onError(e.message));
    }
  }

  addProduct(Product product, File image, Function callback) async {
    try {
      _setState(ProductsState.onRequest());
      final ref =
          _storage.ref().child('products/${Path.basename(image.path)}}');
      final uploadTask = ref.putFile(image);
      await uploadTask.onComplete;
      final user = await _auth.currentUser();
      product.userId = user.uid;
      product.phoneNumber = user.phoneNumber;
      product.imageUrl = await ref.getDownloadURL();
      await _db.collection('products').document().setData(product.toJson());
      _setState(ProductsState.onProductSuccess());
      callback();
    } catch (e) {
      _setState(ProductsState.onError(e.message));
    }
  }

  updateProduct(
      String id, Product product, File image, Function callback) async {
    try {
      _setState(ProductsState.onRequest());
      if (image != null) {
        final ref =
            _storage.ref().child('products/${Path.basename(image.path)}}');
        final uploadTask = ref.putFile(image);
        await uploadTask.onComplete;
        product.imageUrl = await ref.getDownloadURL();
      }
      final user = await _auth.currentUser();
      product.userId = user.uid;
      product.phoneNumber = user.phoneNumber;
      await _db
          .collection('products')
          .document(id)
          .updateData(product.toJson());
      _setState(ProductsState.onProductSuccess());
      callback();
    } catch (e) {
      print(e);
      _setState(ProductsState.onError('Something went wrong'));
    }
  }

  _setState(ProductsState state) {
    if (!_stateController.isClosed) {
      _stateController.add(state);
    }
  }

  void refresh() {
    if (this.userOnly) {
      _fetchUserProducts(this.userId);
    } else {
      _fetchAllProducts();
    }
  }

  void dispose() {
    _stateController.close();
  }

  Stream<ProductsState> get state => _stateController.stream;
}
