class Favorite {
  final String id;
  final String cityName;
  final double temperature;
  final String weatherIcon;
  final DateTime createdAt;

  Favorite({
    required this.id,
    required this.cityName,
    required this.temperature,
    required this.weatherIcon,
    required this.createdAt,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'] ?? '',
      cityName: json['cityName'] ?? 'Unknown',
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
      weatherIcon: json['weatherIcon'] ?? '01d',
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cityName': cityName,
      'temperature': temperature,
      'weatherIcon': weatherIcon,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
