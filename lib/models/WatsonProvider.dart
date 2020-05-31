import 'package:http/http.dart' as http;
import 'dart:convert';

class WatsonProvider {

  static String url = 'https://api.eu-gb.assistant.watson.cloud.ibm.com/instances/cd1938af-8ea5-4c50-a686-44c85b08756b/v2';
  static String assistantId = 'ea700501-2afb-40b1-b427-511b0f14435f';
  static String version  ='2020-04-01';
  static String username = 'apikey';
  static String apiKey = 'WmBTFrYgds5Qp257iLpxbncnt9IOKny7Ad4ux78g-YkK';
  static String sessionId = '';

  static void createNewSession() async {
    var authn = 'Basic ' + base64Encode(utf8.encode('$username:$apiKey'));
    var response = await http.post(
      '$url/assistants/$assistantId/sessions?version=$version',
      headers: {'Content-Type': 'application/json', 'Authorization': authn},
    );
    final data = json.decode(response.body);
    print(json.decode(response.body));
    if (data != null) {
      sessionId = data['session_id'];
    }
  }

  static void sendAndRecieve(String text) async {
    var authn = 'Basic ' + base64Encode(utf8.encode('$username:$apiKey'));
    Map<String, dynamic> _body = {
      "input": {"text": text},
    };
    var response = await http.post(
      '$url/assistants/$assistantId/sessions/$sessionId/message?version=$version',
      headers: {'Content-Type': 'application/json', 'Authorization': authn},
      body: json.encode(_body),
    );
    final data = json.decode(response.body);
    String message = getTextMessage(data);
    print(message);
  }

  static String getTextMessage(var data) {
    return data['output']['generic'][1]['text'].toString();
  }

  static void deleteSession() {

  }

}