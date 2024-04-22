import 'package:tennis_territory_app/domain/reserve/reserve.dart';
import 'package:tennis_territory_app/domain/reserve/reserve_repository.dart';

class ReserveUseCase {
  final ReserveRepository reserveRepository;

  ReserveUseCase(this.reserveRepository);

  Future<List<Reserve>> viewAllReserve({required DateTime date}) async {
    return await reserveRepository.getAllReserve(date: date);
  }

  Future<Reserve> makeReserve({required Reserve reserve}) async {
    final reservesDay = await reserveRepository.getAllReserve(
        date: reserve.date, upcoming: false);

    if (reservesDay.where((r) => r.courtId == reserve.courtId).length >= 3) {
      throw Exception("La cancha no esta disponible para este día");
    }

    return await reserveRepository.addReserve(reserve: reserve);
  }

  Future<void> cancelReserve({required String id}) async {
    return await reserveRepository.deleteReserve(id: id);
  }
}
