import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './MandiState.dart';
import '../../../models/Crop.dart';
import '../../../config.dart';

class MandiBloc {
  MandiBloc() {
    _fetchCrops();
  }

  StreamController<MandiState> _stateController =
      StreamController<MandiState>.broadcast();

  void _fetchCrops() async {
    try {
      final response = await http.get(MANDI_API_URL);
      final jsonData = json.decode(response.body);
      final cropsJson = jsonData['data'];
      List<Crop> crops = [];
      cropsJson.forEach((doc) => crops.add(Crop.fromJson(doc)));
      _setState(MandiState.onSuccess(crops));
    } catch (e) {
      print(e);
      _setState(MandiState.onError('Something went wrong!'));
    }
  }

  _setState(MandiState state) {
    if (!_stateController.isClosed) {
      _stateController.add(state);
    }
  }

  void refresh() {
    _fetchCrops();
  }

  void dispose() {
    _stateController.close();
  }

  Stream<MandiState> get state => _stateController.stream;
}
