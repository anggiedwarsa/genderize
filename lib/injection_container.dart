import 'package:dio/dio.dart';
import 'package:genderize/core/network/network_info.dart';
import 'package:genderize/features/data/datasources/genderize/genderize_local_data_source.dart';
import 'package:genderize/features/data/datasources/genderize/genderize_remote_data_source.dart';
import 'package:genderize/features/data/datasources/nationalize/nationalize_local_data_source.dart';
import 'package:genderize/features/data/datasources/nationalize/nationalize_remote_data_source.dart';
import 'package:genderize/features/data/repositories/genderize/genderize_repository_impl.dart';
import 'package:genderize/features/data/repositories/nationalize/nationalize_repository_impl.dart';
import 'package:genderize/features/domain/repositories/genderize/genderize_repository.dart';
import 'package:genderize/features/domain/repositories/nationalize/nationalize_repository.dart';
import 'package:genderize/features/domain/usecases/genderize/get_prediction.dart';
import 'package:genderize/features/domain/usecases/nationalize/get_prediction_country.dart';
import 'package:genderize/features/presentation/bloc/genderize/genderize_bloc.dart';
import 'package:genderize/features/presentation/bloc/nationalize/nationalize_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  sl.registerFactory(() => GenderizeBloc(getPrediction: sl()));
  sl.registerFactory(() => NationalizeBloc(getPredictionCountry: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetPrediction(sl()));
  sl.registerLazySingleton(() => GetPredictionCountry(sl()));

  // Repository
  sl.registerLazySingleton<GenderizeRepository>(() => GenderizeRepositoryImpl(
      localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<NationalizeRepository>(() =>
      NationalizeRepositoryImpl(
          localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<GenderizeLocalDataSource>(
      () => GenderizeLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<GenderizeRemoteDataSource>(
      () => GenderizeRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<NationalizeLocalDataSource>(
      () => NationalizeLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<NationalizeRemoteDataSource>(
      () => NationalizeRemoteDataSourceImpl(dio: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
