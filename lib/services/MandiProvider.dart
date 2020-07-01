import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Crop.dart';

class MandiProvider {

  static final url = 'https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd0000019b744bced621467059a863d32c0bfdf0&format=json&offset=0&limit=10';

  static Future<List<Crop>> fetchCropsData() async {
    try {
      List<Crop> crops = [];
      final response = await http.get(url);
      final data = json.decode(response.body);
      final List docs = data['records'];
      docs.forEach((doc) => crops.add(Crop.fromJson(doc)));
      return crops;
    } catch (e) {
      print(e);
    }
    return [];
  }

}