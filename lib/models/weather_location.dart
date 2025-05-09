class WeatherLocation {
  final String searchcity;
  final String searchregion;
  final String searchcountry;
  final double searchtemperature;
  final String searchcondition;
  final String searchiconUrl;
  final String? searchsunrise;
  final String? searchsunset;
  final double? searchmaxTemp;
  final double? searchminTemp;

  WeatherLocation({
    required this.searchcity,
    required this.searchregion,
    required this.searchcountry,
    required this.searchtemperature,
    required this.searchcondition,
    required this.searchiconUrl,
    this.searchsunrise,
    this.searchsunset,
    this.searchmaxTemp,
    this.searchminTemp,
  });

  factory WeatherLocation.fromJson(Map<String, dynamic> json) {
    return WeatherLocation(
      searchcity: json['location']['name'],
      searchregion: json['location']['region'],
      searchcountry: json['location']['country'],
      searchtemperature: json['current']['temp_c'].toDouble(),
      searchcondition: json['current']['condition']['text'],
      searchiconUrl: "https:${json['current']['condition']['icon']}",
      searchsunrise: json['forecast']?['forecastday']?[0]?['astro']?['sunrise'],
      searchsunset: json['forecast']?['forecastday']?[0]?['astro']?['sunset'],
      searchmaxTemp:
          json['forecast']?['forecastday']?[0]?['day']?['maxtemp_c']
              ?.toDouble(),
      searchminTemp:
          json['forecast']?['forecastday']?[0]?['day']?['mintemp_c']
              ?.toDouble(),
    );
  }
}
