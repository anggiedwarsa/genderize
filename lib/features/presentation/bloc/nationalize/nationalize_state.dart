part of 'nationalize_bloc.dart';

abstract class NationalizeState extends Equatable {
  const NationalizeState();

  @override
  List<Object> get props => [];
}

class NationalizeInitial extends NationalizeState {}

class NationalizeLoading extends NationalizeState {}

class NationalizeLoaded extends NationalizeState {
  final Nationalize nationalize;

  const NationalizeLoaded({required this.nationalize});

  @override
  List<Object> get props => [nationalize];

  @override
  String toString() {
    return 'NationalizeLoaded{nationalize: $nationalize}';
  }
}

class NationalizeError extends NationalizeState {
  final String message;

  const NationalizeError({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return 'NationalizeError{message: $message}';
  }
}
