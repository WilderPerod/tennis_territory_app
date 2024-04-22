import 'package:flutter_test/flutter_test.dart';
import 'package:tennis_territory_app/data/repositories/weather_repository_impl.dart';
import 'package:tennis_territory_app/domain/weather/weather_use_cases.dart';

void main() {
  final WeatherUseCases weatherUseCases =
      WeatherUseCases(weatherRepositoryImpl: WeatherRepositoryImpl());

  group(
    'Weather API',
    () {
      test('fetchData', () async {
        const double latitude = 10.48;
        const double longitude = -66.87;

        final getReserve = await weatherUseCases.getPrecipProbDays(
            latitude: latitude, longitude: longitude);

        expect(getReserve.precipProbDays.length, 15);
      });
    },
  );
}
