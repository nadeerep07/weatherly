import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/favorite_model.dart';

class Api {
  static const baseUrl = 'http://10.0.15.198:3000/api/';

  static addFavorite(FavoriteModel location) async {
    print("Adding to favorites: ${location.name}");

    var url = Uri.parse('${baseUrl}add_favorite');

    try {
      final res = await http.post(
        url,
        body: {
          'cityname': location.name,
          'countryname': location.country,
          'regionname': location.region,
        },
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print("Response: ${data}");
      } else {
        print("Error: ${res.statusCode}");
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  static getFavorite() async {
    List<FavoriteModel> favoriteLocations = [];
    var url = Uri.parse('${baseUrl}get_favorite');
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        print("Response: ${res.body}");
        var data = jsonDecode(res.body);
        data['favorite'].forEach(
          (value) => {
            favoriteLocations.add(
              FavoriteModel(
                name: value['name'],
                country: value['country'],
                region: value['region'],
              ),
            ),
          },
        );
        return favoriteLocations;
      } else {
        print('Error: ${res.statusCode}');
        return [];
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      return [];
    }
  }
}
