import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import './ProductsState.dart';
import '../../../models/Product.dart';

class ProductsBloc {
  bool userOnly;
  String userId;
  Firestore _db = Firestore.instance;

  ProductsBloc({String userId}) {
    if (userId != null) {
      _fetchUserProducts(userId);
      this.userOnly = true;
    } else {
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
