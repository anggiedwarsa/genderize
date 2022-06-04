import 'package:dio/dio.dart';
import 'package:genderize/core/error/exceptions.dart';
import 'package:genderize/core/network/network_info.dart';
import 'package:genderize/features/genderize/data/datasources/genderize_local_data_source.dart';
import 'package:genderize/features/genderize/data/datasources/genderize_remote_data_source.dart';
import 'package:genderize/features/genderize/data/models/genderize_model.dart';
import 'package:genderize/features/genderize/domain/entities/genderize.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:genderize/features/genderize/domain/repositories/genderize_repository.dart';

typedef Future<GenderizeModel> _GetPrediction();

class GenderizeRepositoryImpl implements GenderizeRepository {
  final GenderizeLocalDataSource localDataSource;
  final GenderizeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GenderizeRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  Future<Either<Failure, Genderize>> _getPrediction(
      _GetPrediction getPrediction) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await getPrediction();
        localDataSource.cacheGender(response);
        return Right(response);
      } on DioError catch (error) {
        return Left(ServerFailure());
      } on GenderNotFoundFailure {
        return Left(GenderNotFoundFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localGender = await localDataSource.getPrediction();
        return Right(localGender!);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Genderize>> getPrediction(String name) async {
    // TODO: implement getPrediction
    return await _getPrediction(() {
      return remoteDataSource.getPrediction(name)!;
    });
  }
}
