import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/features/genderize/domain/entities/genderize.dart';
import 'package:genderize/features/genderize/domain/usecases/get_prediction.dart';

part 'genderize_event.dart';

part 'genderize_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String failedPredictionMessage = 'Maaf, sistem tidak bisa memprediksi nama ini.';

class GenderizeBloc extends Bloc<GenderizeEvent, GenderizeState> {
  final GetPrediction getPrediction;

  GenderizeState get initialState => GenderizeInitial();

  GenderizeBloc({required this.getPrediction}) : super(GenderizeInitial()) {
    on<GetPredictionGender>(_onGetPredictionGender);
  }

  FutureOr<void> _onGetPredictionGender(
    GetPredictionGender event,
    Emitter<GenderizeState> emit,
  ) async {
    emit(GenderizeLoading());
    final result = await getPrediction(
      GenderizeParams(
        name: event.name,
      ),
    );
    emit(
      result.fold(
        (failure) {
          var errorMessage = 'Unexpected error';
          if (failure is ServerFailure) {
            errorMessage = serverFailureMessage;
          } else if (failure is CacheFailure) {
            errorMessage = cacheFailureMessage;
          }
          return GenderizeError(message: errorMessage);
        },
        (genderize) => GenderizeLoaded(genderize: genderize),
      ),
    );
  }
}
