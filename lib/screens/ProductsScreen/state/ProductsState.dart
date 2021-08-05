import 'package:agro_acres/models/Product.dart';

class ProductsState {
  List<Product> products;
  bool isLoading = false;
  String error;

  ProductsState.onRequest() {
    this.isLoading = true;
  }

  ProductsState.onSuccess(this.products) {
    this.isLoading = false;
  }

  ProductsState.onError(this.error) {
    this.isLoading = false;
  }
}
