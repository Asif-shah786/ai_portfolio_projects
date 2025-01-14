part of 'emplyee_productivity_bloc.dart';

sealed class EmplyeeProductivityState extends Equatable {
  const EmplyeeProductivityState();

  @override
  List<Object> get props => [];
}

final class EmplyeeProductivityInitial extends EmplyeeProductivityState {}

final class EmplyeeProductivityLoading extends EmplyeeProductivityState {}

final class EmplyeeProductivityLoaded extends EmplyeeProductivityState {
  final int prediction;

  const EmplyeeProductivityLoaded({required this.prediction});
}

final class EmplyeeProductivityError extends EmplyeeProductivityState {
  final String message;

  const EmplyeeProductivityError(this.message);

  @override
  List<Object> get props => [message];
}
