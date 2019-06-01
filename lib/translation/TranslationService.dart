import 'dart:convert';

import 'package:flutter_hackathon/translation/TranslationResponse.dart';
import 'package:http/http.dart' as http;

String apiKey = "AIzaSyBg-EiyCyYqIFOffHqHhgkrm4ILJSl2V4I";

Future<Translation> translateString(String source, String languageCode) async {
  String url =
      "https://translation.googleapis.com/language/translate/v2?target=${languageCode}&key=${apiKey}&q=${source}";

  var response = await http.get(url);
  //print(response.body);
  var jsonResponse = json.decode(response.body);
  TranslationResponse translationResponse =
      TranslationResponse.fromJson(jsonResponse);
  Translation translation = translationResponse.data.translations[0];
  return translation;
}
