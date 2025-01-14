import 'package:ai_portfolio_projects/models/productivity_sample_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../libraries/productivity_service.dart';

part 'emplyee_productivity_event.dart';
part 'emplyee_productivity_state.dart';

@injectable
class EmplyeeProductivityBloc extends Bloc<EmplyeeProductivityEvent, EmplyeeProductivityState> {
  final ProductivityService _productivityService;

  EmplyeeProductivityBloc(this._productivityService) : super(EmplyeeProductivityInitial()) {
    on<PredictProductivity>((event, emit) async {
      try {
        emit(EmplyeeProductivityLoading());
        final prediction = await _productivityService.fetchProductivity(event.sample);
        emit(EmplyeeProductivityLoaded(prediction: prediction));
      } catch (e) {
        emit(EmplyeeProductivityError(e.toString()));
      }
    });
  }
}
