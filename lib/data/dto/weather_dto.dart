// To parse this JSON data, do
//
//     final weatherDto = weatherDtoFromJson(jsonString);

import 'dart:convert';

WeatherDto weatherDtoFromJson(String str) =>
    WeatherDto.fromJson(json.decode(str));

String weatherDtoToJson(WeatherDto data) => json.encode(data.toJson());

class WeatherDto {
  int queryCost;
  double latitude;
  double longitude;
  String resolvedAddress;
  String address;
  String timezone;
  double tzoffset;
  String description;
  List<CurrentConditions> days;
  List<dynamic> alerts;
  Map<String, Station> stations;
  CurrentConditions currentConditions;

  WeatherDto({
    required this.queryCost,
    required this.latitude,
    required this.longitude,
    required this.resolvedAddress,
    required this.address,
    required this.timezone,
    required this.tzoffset,
    required this.description,
    required this.days,
    required this.alerts,
    required this.stations,
    required this.currentConditions,
  });

  factory WeatherDto.fromJson(Map<String, dynamic> json) => WeatherDto(
        queryCost: json["queryCost"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        resolvedAddress: json["resolvedAddress"],
        address: json["address"],
        timezone: json["timezone"],
        tzoffset: json["tzoffset"],
        description: json["description"],
        days: List<CurrentConditions>.from(
            json["days"].map((x) => CurrentConditions.fromJson(x))),
        alerts: List<dynamic>.from(json["alerts"].map((x) => x)),
        stations: Map.from(json["stations"])
            .map((k, v) => MapEntry<String, Station>(k, Station.fromJson(v))),
        currentConditions:
            CurrentConditions.fromJson(json["currentConditions"]),
      );

  Map<String, dynamic> toJson() => {
        "queryCost": queryCost,
        "latitude": latitude,
        "longitude": longitude,
        "resolvedAddress": resolvedAddress,
        "address": address,
        "timezone": timezone,
        "tzoffset": tzoffset,
        "description": description,
        "days": List<dynamic>.from(days.map((x) => x.toJson())),
        "alerts": List<dynamic>.from(alerts.map((x) => x)),
        "stations": Map.from(stations)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "currentConditions": currentConditions.toJson(),
      };
}

class CurrentConditions {
  String datetime;
  int datetimeEpoch;
  double temp;
  double feelslike;
  double humidity;
  double dew;
  double precip;
  double precipprob;
  double snow;
  double snowdepth;
  List<Icon>? preciptype;
  double windgust;
  double windspeed;
  double winddir;
  double pressure;
  double visibility;
  double cloudcover;
  double solarradiation;
  double solarenergy;
  double uvindex;
  Conditions? conditions;
  Icon? icon;
  List<Id>? stations;
  Source? source;
  String? sunrise;
  int? sunriseEpoch;
  String? sunset;
  int? sunsetEpoch;
  double? moonphase;
  double? tempmax;
  double? tempmin;
  double? feelslikemax;
  double? feelslikemin;
  double? precipcover;
  double? severerisk;
  String? description;
  List<CurrentConditions>? hours;

  CurrentConditions({
    required this.datetime,
    required this.datetimeEpoch,
    required this.temp,
    required this.feelslike,
    required this.humidity,
    required this.dew,
    required this.precip,
    required this.precipprob,
    required this.snow,
    required this.snowdepth,
    this.preciptype,
    required this.windgust,
    required this.windspeed,
    required this.winddir,
    required this.pressure,
    required this.visibility,
    required this.cloudcover,
    required this.solarradiation,
    required this.solarenergy,
    required this.uvindex,
    this.conditions,
    this.icon,
    this.stations,
    this.source,
    this.sunrise,
    this.sunriseEpoch,
    this.sunset,
    this.sunsetEpoch,
    this.moonphase,
    this.tempmax,
    this.tempmin,
    this.feelslikemax,
    this.feelslikemin,
    this.precipcover,
    this.severerisk,
    this.description,
    this.hours,
  });

  factory CurrentConditions.fromJson(Map<String, dynamic> json) =>
      CurrentConditions(
          datetime: json["datetime"],
          datetimeEpoch: json["datetimeEpoch"],
          temp: json["temp"]?.toDouble(),
          feelslike: json["feelslike"]?.toDouble(),
          humidity: json["humidity"]?.toDouble(),
          dew: json["dew"]?.toDouble(),
          precip: json["precip"]?.toDouble(),
          precipprob: json["precipprob"]?.toDouble(),
          snow: json["snow"],
          snowdepth: json["snowdepth"],
          preciptype: [],
          windgust: json["windgust"]?.toDouble(),
          windspeed: json["windspeed"]?.toDouble(),
          winddir: json["winddir"]?.toDouble(),
          pressure: json["pressure"]?.toDouble(),
          visibility: json["visibility"]?.toDouble(),
          cloudcover: json["cloudcover"]?.toDouble(),
          solarradiation: json["solarradiation"]?.toDouble(),
          solarenergy: json["solarenergy"]?.toDouble(),
          uvindex: json["uvindex"],
          conditions: conditionsValues.map[json["conditions"]],
          icon: iconValues.map[json["icon"]],
          stations: [],
          source: sourceValues.map[json["source"]],
          sunrise: json["sunrise"],
          sunriseEpoch: json["sunriseEpoch"],
          sunset: json["sunset"],
          sunsetEpoch: json["sunsetEpoch"],
          moonphase: json["moonphase"]?.toDouble(),
          tempmax: json["tempmax"]?.toDouble(),
          tempmin: json["tempmin"]?.toDouble(),
          feelslikemax: json["feelslikemax"]?.toDouble(),
          feelslikemin: json["feelslikemin"]?.toDouble(),
          precipcover: json["precipcover"]?.toDouble(),
          severerisk: json["severerisk"],
          description: json["description"],
          hours: []);

  Map<String, dynamic> toJson() => {
        "datetime": datetime,
        "datetimeEpoch": datetimeEpoch,
        "temp": temp,
        "feelslike": feelslike,
        "humidity": humidity,
        "dew": dew,
        "precip": precip,
        "precipprob": precipprob,
        "snow": snow,
        "snowdepth": snowdepth,
        "preciptype": [],
        "windgust": windgust,
        "windspeed": windspeed,
        "winddir": winddir,
        "pressure": pressure,
        "visibility": visibility,
        "cloudcover": cloudcover,
        "solarradiation": solarradiation,
        "solarenergy": solarenergy,
        "uvindex": uvindex,
        "conditions": conditionsValues.reverse[conditions],
        "icon": iconValues.reverse[icon],
        "stations": [],
        "source": sourceValues.reverse[source],
        "sunrise": sunrise,
        "sunriseEpoch": sunriseEpoch,
        "sunset": sunset,
        "sunsetEpoch": sunsetEpoch,
        "moonphase": moonphase,
        "tempmax": tempmax,
        "tempmin": tempmin,
        "feelslikemax": feelslikemax,
        "feelslikemin": feelslikemin,
        "precipcover": precipcover,
        "severerisk": severerisk,
        "description": description,
        "hours": []
      };
}

enum Conditions {
  CLEAR,
  OVERCAST,
  PARTIALLY_CLOUDY,
  RAIN,
  RAIN_OVERCAST,
  RAIN_PARTIALLY_CLOUDY
}

final conditionsValues = EnumValues({
  "Clear": Conditions.CLEAR,
  "Overcast": Conditions.OVERCAST,
  "Partially cloudy": Conditions.PARTIALLY_CLOUDY,
  "Rain": Conditions.RAIN,
  "Rain, Overcast": Conditions.RAIN_OVERCAST,
  "Rain, Partially cloudy": Conditions.RAIN_PARTIALLY_CLOUDY
});

enum Icon {
  CLEAR_DAY,
  CLEAR_NIGHT,
  CLOUDY,
  FOG,
  PARTLY_CLOUDY_DAY,
  PARTLY_CLOUDY_NIGHT,
  RAIN
}

final iconValues = EnumValues({
  "clear-day": Icon.CLEAR_DAY,
  "clear-night": Icon.CLEAR_NIGHT,
  "cloudy": Icon.CLOUDY,
  "fog": Icon.FOG,
  "partly-cloudy-day": Icon.PARTLY_CLOUDY_DAY,
  "partly-cloudy-night": Icon.PARTLY_CLOUDY_NIGHT,
  "rain": Icon.RAIN
});

enum Source { FCST, OBS }

final sourceValues = EnumValues({"fcst": Source.FCST, "obs": Source.OBS});

enum Id { D4699, D8868, KGAI, KIAD, KJYO, VA060 }

final idValues = EnumValues({
  "D4699": Id.D4699,
  "D8868": Id.D8868,
  "KGAI": Id.KGAI,
  "KIAD": Id.KIAD,
  "KJYO": Id.KJYO,
  "VA060": Id.VA060
});

class Station {
  double distance;
  double latitude;
  double longitude;
  int useCount;
  Id? id;
  String name;
  int quality;
  double contribution;

  Station({
    required this.distance,
    required this.latitude,
    required this.longitude,
    required this.useCount,
    this.id,
    required this.name,
    required this.quality,
    required this.contribution,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        distance: json["distance"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        useCount: json["useCount"],
        id: idValues.map[json["id"]],
        name: json["name"],
        quality: json["quality"],
        contribution: json["contribution"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "latitude": latitude,
        "longitude": longitude,
        "useCount": useCount,
        "id": idValues.reverse[id],
        "name": name,
        "quality": quality,
        "contribution": contribution,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
