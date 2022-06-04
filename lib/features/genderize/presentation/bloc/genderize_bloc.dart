import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/features/genderize/domain/entities/genderize.dart';
import 'package:genderize/features/genderize/domain/usecases/get_prediction.dart';

part 'genderize_event.dart';
part 'genderize_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String FAILED_PREDICTION_MESSAGE =
    'Maaf, sistem tidak bisa memprediksi nama ini.';

class GenderizeBloc extends Bloc<GenderizeEvent, GenderizeState> {
  final GetPrediction getPrediction;

  GenderizeState get initialState => GenderizeInitial();

  GenderizeBloc({required this.getPrediction}) : super(GenderizeInitial()) {
    on<GetPredictionGender>((event, emit) async {
      emit(GenderizeLoading());
      var result = await getPrediction(GenderizeParams(name: event.name));
      result!.fold((failure) {
        emit(GenderizeError(message: _mapFailureToMessage(failure)));
      }, (genderize) {
        emit(GenderizeLoaded(genderize: genderize));
      });
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case GenderNotFoundFailure:
        return FAILED_PREDICTION_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
