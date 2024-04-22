import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tennis_territory_app/data/repositories/reserve_repository_impl.dart';
import 'package:tennis_territory_app/data/repositories/weather_repository_impl.dart';
import 'package:tennis_territory_app/domain/reserve/reserve.dart';
import 'package:tennis_territory_app/domain/reserve/reserve_use_cases.dart';
import 'package:tennis_territory_app/domain/weather/weather_use_cases.dart';

part 'reserve_event.dart';
part 'reserve_state.dart';

class ReserveBloc extends Bloc<ReserveEvent, ReserveState> {
  final ReserveRepositoryImpl reserveRepositoryImpl;
  final WeatherRepositoryImpl weatherRepositoryImpl;
  late ReserveUseCase reserveUseCase;
  late WeatherUseCases weatherUseCases;

  // Data
  Map<String, double> precipProbDays = {};

  ReserveBloc(
      {required this.reserveRepositoryImpl,
      required this.weatherRepositoryImpl})
      : super(ReserveInitial()) {
    reserveUseCase = ReserveUseCase(reserveRepositoryImpl);
    weatherUseCases =
        WeatherUseCases(weatherRepositoryImpl: weatherRepositoryImpl);

    on<LoadReserve>((event, emit) async {
      try {
        emit(ReserveLoading());

        List<Reserve> reserves =
            await reserveUseCase.viewAllReserve(date: event.date);

        precipProbDays = (await weatherUseCases.getPrecipProbDays(
                latitude: event.latitude, longitude: event.longitude))
            .precipProbDays;

        reserves = reserves.map(
          (r) {
            r.precipProb =
                precipProbDays[r.date.toString().split(' ')[0]]?.toString();

            return r;
          },
        ).toList();

        emit(ReserveLoaded(reserves: reserves));
      } catch (e) {
        emit(ReserveError(
            errorMessage: e.toString().replaceAll('Exception:', ''),
            state: const []));
      }
    });

    on<AddReserve>((event, emit) async {
      final currentReserves = state is ReserveLoaded
          ? (state as ReserveLoaded).reserves
          : (state as ReserveError).state;
      try {
        emit(ReserveLoading());

        final reserve = await reserveUseCase.makeReserve(
            reserve: Reserve(
                courtId: event.courtId,
                date: event.date,
                userName: event.userName));

        reserve.precipProb =
            precipProbDays[reserve.date.toString().split(' ')[0]]?.toString();

        currentReserves.add(reserve);

        emit(ReserveSuccess());
      } catch (e) {
        emit(ReserveError(
            errorMessage: e.toString().replaceAll('Exception:', ''),
            state: currentReserves));
      }
      emit(ReserveLoaded(
          reserves: currentReserves..sort((a, b) => a.date.compareTo(b.date))));
    });

    on<DeleteReserve>((event, emit) async {
      final currentReserves = (state as ReserveLoaded).reserves;
      try {
        emit(ReserveLoading());

        await reserveUseCase.cancelReserve(id: event.reserveId);

        emit(ReserveLoaded(
            reserves: currentReserves
              ..removeWhere((reserve) => reserve.id == event.reserveId)));
      } catch (e) {
        emit(ReserveError(
            errorMessage: e.toString().replaceAll('Exception:', ''),
            state: currentReserves));
      }
    });
  }
}
