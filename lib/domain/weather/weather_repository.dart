import 'package:tennis_territory_app/domain/weather/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getForecast15Days(
      {required double latitude, required double longitude});
}
