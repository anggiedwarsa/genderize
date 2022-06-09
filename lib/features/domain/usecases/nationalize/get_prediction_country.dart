import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/core/usecases/usecases.dart';
import 'package:genderize/features/domain/entities/nationalize/nationalize.dart';
import 'package:genderize/features/domain/repositories/nationalize/nationalize_repository.dart';

class GetPredictionCountry implements UseCase<Nationalize, NationalizeParams> {
  final NationalizeRepository nationalizeRepository;

  GetPredictionCountry(this.nationalizeRepository);

  @override
  Future<Either<Failure, Nationalize>> call(NationalizeParams params) async {
    return await nationalizeRepository.getPredictionCountry(params.name);
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
