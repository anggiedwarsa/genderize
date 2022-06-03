import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'genderize_event.dart';
part 'genderize_state.dart';

class GenderizeBloc extends Bloc<GenderizeEvent, GenderizeState> {
  GenderizeBloc() : super(GenderizeInitial()) {
    on<GenderizeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
