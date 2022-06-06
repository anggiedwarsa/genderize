import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/core/util/string_helper.dart';
import 'package:genderize/features/genderize/domain/entities/genderize.dart';
import 'package:genderize/features/genderize/domain/usecases/get_prediction.dart';

part 'genderize_event.dart';

part 'genderize_state.dart';

class GenderizeBloc extends Bloc<GenderizeEvent, GenderizeState> {
  final GetPrediction getPrediction;

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
          var errorMessage = StringHelper.unexpectedError;
          if (failure is ServerFailure) {
            errorMessage = StringHelper.serverFailureMessage;
          } else if (failure is CacheFailure) {
            errorMessage = StringHelper.cacheFailureMessage;
          }
          return GenderizeError(message: errorMessage);
        },
        (genderize) {
          if (genderize.gender == null) {
            return const GenderizeError(message: StringHelper.failedPredictionMessage);
          } else {
            return GenderizeLoaded(genderize: genderize);
          }
        },
      ),
    );
  }
}
