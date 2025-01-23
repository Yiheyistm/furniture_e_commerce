import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadApiKey() async {
  // Load the file as a string
  final String jsonString = await rootBundle.loadString('secret_api_key.json');

  // Parse the string into a JSON object
  final Map<String, dynamic> jsonData = json.decode(jsonString);

  return jsonData;
}
