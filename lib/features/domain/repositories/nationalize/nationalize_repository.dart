import 'package:dartz/dartz.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/features/data/models/nationalize/nationalize_model.dart';

abstract class NationalizeRepository {
  Future<Either<Failure, NationalizeModel>> getPredictionCountry(String name);
}
