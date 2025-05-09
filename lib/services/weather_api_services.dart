import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_location.dart';

Future<List<WeatherLocation>> fetchLocations(String query) async {
  String apiKey1 = 'aae948700819404e98f41021250905';
  final url = Uri.parse(
    'http://api.weatherapi.com/v1/search.json?key=$apiKey1&q=$query',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((item) => WeatherLocation.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load locations');
  }
}
