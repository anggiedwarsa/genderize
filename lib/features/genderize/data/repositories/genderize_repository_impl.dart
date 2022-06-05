import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:genderize/core/error/exceptions.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/core/network/network_info.dart';
import 'package:genderize/features/genderize/data/datasources/genderize_local_data_source.dart';
import 'package:genderize/features/genderize/data/datasources/genderize_remote_data_source.dart';
import 'package:genderize/features/genderize/domain/entities/genderize.dart';
import 'package:genderize/features/genderize/domain/repositories/genderize_repository.dart';

class GenderizeRepositoryImpl implements GenderizeRepository {
  final GenderizeLocalDataSource localDataSource;
  final GenderizeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GenderizeRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Genderize>>? getPrediction(String name) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getPrediction(name);
        await localDataSource.cacheGender(response);
        return Right(response);
      } on DioError catch (_) {
        return Left(ServerFailure());
      } on GenderNotFoundFailure {
        return Left(GenderNotFoundFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localGender = await localDataSource.getPrediction();
        final genderize = Genderize(
          name: localGender?.name ?? '-',
          gender: localGender?.gender ?? '-',
        );
        return Right(genderize);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
