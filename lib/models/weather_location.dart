class WeatherLocation {
  final String name;
  final String region;
  final String country;

  WeatherLocation({
    required this.name,
    required this.region,
    required this.country,
  });

  factory WeatherLocation.fromJson(Map<String, dynamic> json) {
    return WeatherLocation(
      name: json['name'],
      region: json['region'],
      country: json['country'],
    );
  }
}
