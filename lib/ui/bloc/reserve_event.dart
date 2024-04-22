part of 'reserve_bloc.dart';

@immutable
sealed class ReserveEvent {}

class LoadReserve extends ReserveEvent {
  final DateTime date;
  final double latitude;
  final double longitude;
  LoadReserve(
      {required this.date, required this.latitude, required this.longitude});
}

class AddReserve extends ReserveEvent {
  final String courtId;
  final DateTime date;
  final String userName;

  AddReserve({
    required this.courtId,
    required this.date,
    required this.userName,
  });
}

class DeleteReserve extends ReserveEvent {
  final String reserveId;

  DeleteReserve(this.reserveId);
}
