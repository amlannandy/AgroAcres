import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import './TutorialState.dart';
import '../../../models/Tutorial.dart';

class TutorialBloc {
  Firestore _db = Firestore.instance;

  TutorialBloc(bool isEnglish) {
    if (isEnglish) {
      _fetchEnglishTutorials();
    } else {
      _fetchHindiTutorials();
    }
  }

  StreamController<TutorialState> _stateController =
      StreamController<TutorialState>.broadcast();

  void _fetchEnglishTutorials() async {
    try {
      final res = await _db.collection('englishTutorials').getDocuments();
      final docs = res.documents;
      final tutorials = docs.map((doc) => Tutorial.fromFirestore(doc)).toList();
      _setState(TutorialState.onSuccess(tutorials));
    } catch (e) {
      _setState(TutorialState.onError('Something went wrong'));
    }
  }

  void _fetchHindiTutorials() async {
    try {
      final res = await _db.collection('hindiTutorials').getDocuments();
      final docs = res.documents;
      final tutorials = docs.map((doc) => Tutorial.fromFirestore(doc)).toList();
      _setState(TutorialState.onSuccess(tutorials));
    } catch (e) {
      _setState(TutorialState.onError('Something went wrong'));
    }
  }

  _setState(TutorialState state) {
    if (!_stateController.isClosed) {
      _stateController.add(state);
    }
  }

  void refresh(bool isEnglish) {
    if (isEnglish) {
      _fetchEnglishTutorials();
    } else {
      _fetchHindiTutorials();
    }
  }

  void dispose() {
    _stateController.close();
  }

  Stream<TutorialState> get state => _stateController.stream;
}
