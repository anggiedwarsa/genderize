import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/core/usecases/usecases.dart';
import 'package:genderize/features/genderize/domain/entities/genderize.dart';
import 'package:genderize/features/genderize/domain/repositories/genderize_repository.dart';

class GetPrediction implements UseCase<Genderize, GenderizeParams> {
  final GenderizeRepository repository;

  GetPrediction(this.repository);

  @override
  Future<Either<Failure, Genderize>> call(GenderizeParams params) async {
    return await repository.getPrediction(params.name);
  }
}

class GenderizeParams extends Equatable {
  final String name;

  const GenderizeParams({required this.name});

  @override
  List<Object?> get props => [name];

  @override
  String toString() {
    return 'GenderizeParams{name: $name}';
  }
}
