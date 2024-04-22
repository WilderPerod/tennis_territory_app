class Weather {
  Map<String, double> precipProbDays;

  Weather({required this.precipProbDays});

  factory Weather.fromJson(Map<String, dynamic> json) {
    Map<String, double> parsedPrecipProbDays = {};
    json['precipProbDays'].forEach((key, value) {
      parsedPrecipProbDays[key] = value.toDouble();
    });
    return Weather(precipProbDays: parsedPrecipProbDays);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['precipProbDays'] = precipProbDays;
    return json;
  }
}
