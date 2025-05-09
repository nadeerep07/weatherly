import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/fav_weather_model.dart';

  String apiKey1 = 'aae948700819404e98f41021250905';

class WeatherService {

  static Future<FavWeatherModel> getWeather(String city) async {
    final url = Uri.parse("https://api.weatherapi.com/v1/forecast.json?key=$apiKey1&q=$city&days=1");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return FavWeatherModel.fromJson(data);
    } else {
      throw Exception("Failed to load weather for $city");
    }
  }
}
