import 'package:weather_app/models/favorite_model.dart';

class FavoritesApiService {
  // Comment out the HTTP implementation for now
  /*
  static const String baseUrl = 'http://10.0.2.2:3000';

  Future<List<Favorite>> getFavorites() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/favorites')).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw Exception('Request timed out');
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Favorite.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load favorites: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<Favorite> addFavorite(Favorite favorite) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/favorites'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(favorite.toJson()),
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw Exception('Request timed out');
        },
      );
      if (response.statusCode == 201) {
        return Favorite.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add favorite: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<void> deleteFavorite(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/favorites/$id')).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw Exception('Request timed out');
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete favorite: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
  */

  // Mock implementation for testing
  Future<List<Favorite>> getFavorites() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return [
      Favorite(
        id: '1',
        cityName: 'London',
        temperature: 15.0,
        weatherIcon: '01d',
        createdAt: DateTime.now(),
      ),
      Favorite(
        id: '2',
        cityName: 'New York',
        temperature: 20.0,
        weatherIcon: '02d',
        createdAt: DateTime.now(),
      ),
    ];
  }

  Future<Favorite> addFavorite(Favorite favorite) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return Favorite(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      cityName: favorite.cityName,
      temperature: favorite.temperature,
      weatherIcon: favorite.weatherIcon,
      createdAt: favorite.createdAt,
    );
  }

  Future<void> deleteFavorite(String id) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // No-op for mock; assume success
  }
}
