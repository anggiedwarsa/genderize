import 'package:dartz/dartz.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/features/domain/entities/nationalize/nationalize.dart';

abstract class NationalizeRepository {
  Future<Either<Failure, Nationalize>> getPredictionCountry(String name);
}
