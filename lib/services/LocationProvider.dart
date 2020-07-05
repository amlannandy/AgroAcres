import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = 'AIzaSyDBVjfQa1q54VHunVlWzaUDOvTmdkqUzC0';

class LocationProvider {

  static String generateLocationPreviewImage(double latitude, double longitude) {

    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';

  }

  static Future<String> getPlaceAddress(double lat, double lng) async {

    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];

  }

}