import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/core/usecases/usecases.dart';
import 'package:genderize/features/data/models/genderize/genderize_model.dart';
import 'package:genderize/features/domain/repositories/genderize/genderize_repository.dart';

class GetPrediction implements UseCase<GenderizeModel, GenderizeParams> {
  final GenderizeRepository repository;

  GetPrediction(this.repository);

  @override
  Future<Either<Failure, GenderizeModel>> call(GenderizeParams params) async {
    return repository.getPrediction(params.name);
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
