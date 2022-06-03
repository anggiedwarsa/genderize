part of 'genderize_bloc.dart';

abstract class GenderizeEvent extends Equatable {
  const GenderizeEvent();

  @override
  List<Object> get props => [];
}

class GetPredictionGender extends GenderizeEvent {
  final String name;

  GetPredictionGender(this.name);
}
