import 'package:dartz/dartz.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/features/domain/entities/genderize/genderize.dart';

abstract class GenderizeRepository {
  Future<Either<Failure, Genderize>> getPrediction(String name);
}
