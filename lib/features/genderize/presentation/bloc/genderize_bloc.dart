import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/features/genderize/domain/entities/genderize.dart';
import 'package:genderize/features/genderize/domain/usecases/get_prediction.dart';

part 'genderize_event.dart';
part 'genderize_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String failedPredictionMessage =
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
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      case GenderNotFoundFailure:
        return failedPredictionMessage;
      default:
        return 'Unexpected error';
    }
  }
}
