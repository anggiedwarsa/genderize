import 'package:dartz/dartz.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/features/data/models/genderize/genderize_model.dart';

abstract class GenderizeRepository {
  Future<Either<Failure, GenderizeModel>> getPrediction(String name);
}
