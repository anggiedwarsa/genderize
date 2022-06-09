import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/core/util/string_helper.dart';
import 'package:genderize/features/domain/entities/nationalize/nationalize.dart';
import 'package:genderize/features/domain/usecases/nationalize/get_prediction_country.dart';

part 'nationalize_event.dart';
part 'nationalize_state.dart';

class NationalizeBloc extends Bloc<NationalizeEvent, NationalizeState> {
  final GetPredictionCountry getPredictionCountry;

  NationalizeBloc({required this.getPredictionCountry})
      : super(NationalizeInitial()) {
    on<PredictCountryByName>(_onGetPredictionCountry);
  }

  FutureOr<void> _onGetPredictionCountry(
    PredictCountryByName event,
    Emitter<NationalizeState> emit,
  ) async {
    emit(NationalizeLoading());
    final result = await getPredictionCountry(
      NationalizeParams(
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
          return NationalizeError(message: errorMessage);
        },
        (nationalize) {
          if (nationalize.countries == null || nationalize.countries!.isEmpty) {
            return const NationalizeError(
                message: StringHelper.failedPredictionMessage);
          } else {
            return NationalizeLoaded(nationalize: nationalize);
          }
        },
      ),
    );
  }
}
