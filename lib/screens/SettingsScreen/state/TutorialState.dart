import '../../../models/Tutorial.dart';

class TutorialState {
  String message;
  bool isLoading = false;
  List<Tutorial> tutorials;

  TutorialState.onRequest() {
    this.isLoading = false;
  }

  TutorialState.onSuccess(this.tutorials) {
    this.isLoading = false;
  }

  TutorialState.onError(this.message) {
    this.isLoading = false;
  }
}
