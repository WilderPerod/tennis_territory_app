import 'package:tennis_territory_app/domain/reserve/reserve.dart';

abstract class ReserveRepository {
  Future<List<Reserve>> getAllReserve(
      {required DateTime date, bool upcoming = true});
  Future<Reserve> addReserve({required Reserve reserve});
  Future<void> deleteReserve({required String id});
}
