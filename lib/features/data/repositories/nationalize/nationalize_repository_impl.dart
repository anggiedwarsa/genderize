import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:genderize/core/error/exceptions.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/core/network/network_info.dart';
import 'package:genderize/features/data/datasources/nationalize/nationalize_local_data_source.dart';
import 'package:genderize/features/data/datasources/nationalize/nationalize_remote_data_source.dart';
import 'package:genderize/features/domain/entities/nationalize/nationalize.dart';
import 'package:genderize/features/domain/repositories/nationalize/nationalize_repository.dart';

class NationalizeRepositoryImpl implements NationalizeRepository {
  final NationalizeLocalDataSource localDataSource;
  final NationalizeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NationalizeRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Nationalize>> getPredictionCountry(String name) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getPredictionCountry(name);
        await localDataSource.cacheCountry(response);
        return Right(response);
      } on DioError catch (_) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCountry = await localDataSource.getPredictionCountry();
        final nationalize = Nationalize(
          name: localCountry!.name,
          countries: localCountry.countries,
        );
        return Right(nationalize);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
