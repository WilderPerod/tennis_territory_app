import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tennis_territory_app/data/dto/weather_dto.dart';
import 'package:tennis_territory_app/domain/weather/weather.dart';
import 'package:tennis_territory_app/domain/weather/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final String api =
      'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/';
  final String key = 'HH772RYJGQBY78997LVQBTK8V';

  @override
  Future<Weather> getForecast15Days(
      {required double latitude, required double longitude}) async {
    try {
      final Uri uri = Uri.parse('$api$latitude,$longitude');
      final Map<String, String> queryParams = {'key': key};
      final Uri uriWithParams = uri.replace(queryParameters: queryParams);

      final response = await http.get(uriWithParams);
      if (response.statusCode != 200) {
        throw Exception('Ha ocurrido un error al obtener los datos climáticos');
      }
      final weatherDto = WeatherDto.fromJson(jsonDecode(response.body));

      return Weather(
          precipProbDays: weatherDto.days.fold({}, (map, day) {
        map[day.datetime] = day.precipprob;
        return map;
      }));
    } catch (e) {
      debugPrint("Something went wrong when getForecast15Days: $e");
      throw Exception("No se pudierón obtener los datos climáticos");
    }
  }
}
