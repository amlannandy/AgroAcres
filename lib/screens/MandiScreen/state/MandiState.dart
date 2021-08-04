import '../../../models/Crop.dart';

class MandiState {
  List<Crop> crops;
  bool isLoading = false;
  String error;

  MandiState.onRequest() {
    this.isLoading = true;
  }

  MandiState.onSuccess(this.crops) {
    this.isLoading = false;
  }

  MandiState.onError(this.error);
}
