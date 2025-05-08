import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/models/favorite_model.dart';

class FavoritesApiService {
  final String baseUrl = 'https://api.example.com/favorites';

  Future<Favorite> addToFavorites(Favorite favorite) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(favorite.toJson()),
    );

    if (response.statusCode == 201) {
      return Favorite.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add favorite');
    }
  }

  // Example method to add an item to favorites
  Future<void> addFavorite(String item) async {
    // Simulate a network call
    await Future.delayed(Duration(seconds: 1));
    print('$item added to favorites');
  }

  // Example method to remove an item from favorites
  Future<void> removeFavorite(String item) async {
    // Simulate a network call
    await Future.delayed(Duration(seconds: 1));
    print('$item removed from favorites');
  }
}
