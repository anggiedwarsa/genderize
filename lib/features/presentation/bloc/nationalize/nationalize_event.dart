part of 'nationalize_bloc.dart';

abstract class NationalizeEvent extends Equatable {
  const NationalizeEvent();
}

class PredictCountryByName extends NationalizeEvent {
  final String name;

  const PredictCountryByName({required this.name});

  @override
  List<Object?> get props => [name];

  @override
  String toString() {
    return 'PredictCountryByName{name: $name}';
  }
}
