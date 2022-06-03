part of 'genderize_bloc.dart';

abstract class GenderizeState extends Equatable {
  const GenderizeState();

  @override
  List<Object> get props => [];
}

class GenderizeInitial extends GenderizeState {}

class GenderizeLoading extends GenderizeState {}

class GenderizeLoaded extends GenderizeState {
  final Genderize genderize;

  GenderizeLoaded({required this.genderize});
}

class GenderizeError extends GenderizeState {
  final String message;

  GenderizeError({required this.message});
}
