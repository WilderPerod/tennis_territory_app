part of 'reserve_bloc.dart';

@immutable
sealed class ReserveState {}

final class ReserveInitial extends ReserveState {}

final class ReserveLoading extends ReserveState {}

final class ReserveLoaded extends ReserveState {
  final List<Reserve> reserves;

  ReserveLoaded({required this.reserves});
}

final class ReserveSuccess extends ReserveState {}

final class ReserveError extends ReserveState {
  final String errorMessage;
  final List<Reserve> state;
  ReserveError({required this.errorMessage, required this.state});
}
