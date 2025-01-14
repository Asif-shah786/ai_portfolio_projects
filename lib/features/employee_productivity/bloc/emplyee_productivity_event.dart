part of 'emplyee_productivity_bloc.dart';

sealed class EmplyeeProductivityEvent extends Equatable {
  const EmplyeeProductivityEvent();

  @override
  List<Object> get props => [];
}

final class PredictProductivity extends EmplyeeProductivityEvent {
  final ProductivitySample sample;

  const PredictProductivity(this.sample);
}
