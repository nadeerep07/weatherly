class FavWeatherModel {
  final String city;
  final double? tempC;
  final String? condition;
   final String? region;
  final String? country;
  final String? iconUrl;

  FavWeatherModel({required this.city,  this.tempC,  this.condition,
     this.region,  this.country,  this.iconUrl});

  factory FavWeatherModel.fromJson(Map<String, dynamic> json) {
    return FavWeatherModel(
      city: json['location']['name'],
      tempC: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
      region: json['location']['region'],
      country: json['location']['country'],
      iconUrl: "https:${json['current']['condition']['icon']}",
      
    );
  }
}
