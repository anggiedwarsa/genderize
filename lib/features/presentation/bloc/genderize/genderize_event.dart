part of 'genderize_bloc.dart';

abstract class GenderizeEvent extends Equatable {
  const GenderizeEvent();
}

class GetPredictionGender extends GenderizeEvent {
  final String name;

  const GetPredictionGender(this.name);

  @override
  List<Object?> get props => [
    name,
  ];

  @override
  String toString() {
    return 'GetPredictionGender{name: $name}';
  }
}
