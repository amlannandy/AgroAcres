import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Crop.dart';
import '../config.dart';

class MandiProvider {
  static final url =
      'https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=$API_KEY&format=json&offset=0&limit=30';
  static List<Crop> _crops = [];

  static Future<List<Crop>> fetchCropsData() async {
    try {
      List<Crop> crops = [];
      final response = await http.get(url);
      final data = json.decode(response.body);
      final List docs = data['records'];
      docs.forEach((doc) => crops.add(Crop.fromJson(doc)));
      _crops = crops;
      return _crops;
    } catch (e) {
      print(e);
    }
    return [];
  }

  static List<Crop> getCrops() {
    return [..._crops];
  }
}
