
class FavoriteModel {
  final String name;
  final String region;
  final String country;
  FavoriteModel({
    required this.name,
    required this.region,
    required this.country,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      name: json['name'],
      region: json['region'],
      country: json['country'],
    );
  }
}
