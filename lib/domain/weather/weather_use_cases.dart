import 'package:tennis_territory_app/data/repositories/weather_repository_impl.dart';
import 'package:tennis_territory_app/domain/weather/weather.dart';

class WeatherUseCases {
  final WeatherRepositoryImpl weatherRepositoryImpl;

  WeatherUseCases({required this.weatherRepositoryImpl});

  Future<Weather> getPrecipProbDays(
      {required double latitude, required double longitude}) async {
    return await weatherRepositoryImpl.getForecast15Days(
        latitude: latitude, longitude: longitude);
  }
}
