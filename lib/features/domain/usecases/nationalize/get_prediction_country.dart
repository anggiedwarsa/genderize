import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/core/usecases/usecases.dart';
import 'package:genderize/features/data/models/nationalize/nationalize_model.dart';
import 'package:genderize/features/domain/repositories/nationalize/nationalize_repository.dart';

class GetPredictionCountry implements UseCase<NationalizeModel, NationalizeParams> {
  final NationalizeRepository nationalizeRepository;

  GetPredictionCountry(this.nationalizeRepository);

  @override
  Future<Either<Failure, NationalizeModel>> call(NationalizeParams params) async {
    return nationalizeRepository.getPredictionCountry(params.name);
  }
}

class NationalizeParams extends Equatable {
  final String name;

  const NationalizeParams({required this.name});

  @override
  List<Object?> get props => [name];

  @override
  String toString() {
    return 'NationalizeParams{name: $name}';
  }
}
