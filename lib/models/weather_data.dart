class WeatherData {
  final String city;
  final String region;
  final String country;
  final double temperature;
  final String condition;
  final String iconUrl;
  final String? sunrise;
  final String? sunset;
  final double? maxTemp;
  final double? minTemp;

  WeatherData({
    required this.city,
    required this.region,
    required this.country,
    required this.temperature,
    required this.condition,
    required this.iconUrl,
    this.sunrise,
    this.sunset,
    this.maxTemp,
    this.minTemp,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['location']['name'],
      region: json['location']['region'],
      country: json['location']['country'],
      temperature: json['current']['temp_c'].toDouble(),
      condition: json['current']['condition']['text'],
      iconUrl: "https:${json['current']['condition']['icon']}",
      sunrise: json['forecast']?['forecastday']?[0]?['astro']?['sunrise'],
      sunset: json['forecast']?['forecastday']?[0]?['astro']?['sunset'],
      maxTemp:
          json['forecast']?['forecastday']?[0]?['day']?['maxtemp_c']
              ?.toDouble(),
      minTemp:
          json['forecast']?['forecastday']?[0]?['day']?['mintemp_c']
              ?.toDouble(),
    );
  }
}
