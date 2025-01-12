import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvent {}

class HomeSearchSubmitted extends HomeEvent {
  final String query;

  HomeSearchSubmitted(this.query);

  @override
  List<Object?> get props => [query];
}

class HomeClearSearch extends HomeEvent {}
