import '../../../models/Product.dart';

class ProductsState {
  List<Product> products;
  Product currentProduct;
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

  ProductsState.onProductSuccess() {
    this.isLoading = false;
  }
}
