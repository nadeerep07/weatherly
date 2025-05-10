import 'package:flutter/material.dart';
import 'package:weather_app/models/fav_weather_model.dart';

class WeatherCard extends StatelessWidget {
  final FavWeatherModel weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 4,
      child: ListTile(
        leading: Icon(
          Icons.location_city,
          color: Colors.blue,),
        title: Text(weather.city),
        subtitle: Text('${weather.region} - ${weather.country}'),
       trailing: Text(
          '${weather.tempC}°C',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
       
        },
        onLongPress: () {
         
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
