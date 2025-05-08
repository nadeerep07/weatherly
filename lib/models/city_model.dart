class City {
  final String name;
  final double lat;
  final double lon;

  City({required this.name, required this.lat, required this.lon});

  factory City.fromJson(Map<String, dynamic> json) {
    String cityName = json['name'] ?? '';
    String stateName = json['state'] ?? '';
    String countryName = json['country'] ?? '';

    // Format the display name with state and country if available
    String displayName = cityName;
    if (stateName.isNotEmpty) {
      displayName += ', $stateName';
    }
    if (countryName.isNotEmpty) {
      displayName += ', $countryName';
    }

    return City(
      name: displayName,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is City &&
        other.name == name &&
        other.lat == lat &&
        other.lon == lon;
  }

  @override
  int get hashCode => name.hashCode ^ lat.hashCode ^ lon.hashCode;
}
