part of 'genderize_bloc.dart';

abstract class GenderizeState extends Equatable {
  const GenderizeState();

  @override
  List<Object> get props => [];
}

class GenderizeInitial extends GenderizeState {}

class GenderizeLoading extends GenderizeState {}

class GenderizeLoaded extends GenderizeState {
  final GenderizeModel genderize;

  const GenderizeLoaded({required this.genderize});

  @override
  List<Object> get props => [genderize];

  @override
  String toString() {
    return 'GenderizeLoaded{genderize: $genderize}';
  }
}

class GenderizeError extends GenderizeState {
  final String message;

  const GenderizeError({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return 'GenderizeError{message: $message}';
  }
}
