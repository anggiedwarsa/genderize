import 'package:dio/dio.dart';
import 'package:genderize/core/network/network_info.dart';
import 'package:genderize/features/genderize/data/datasources/genderize_local_data_source.dart';
import 'package:genderize/features/genderize/data/datasources/genderize_remote_data_source.dart';
import 'package:genderize/features/genderize/data/repositories/genderize_repository_impl.dart';
import 'package:genderize/features/genderize/domain/repositories/genderize_repository.dart';
import 'package:genderize/features/genderize/domain/usecases/get_prediction.dart';
import 'package:genderize/features/genderize/presentation/bloc/genderize_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  sl.registerFactory(() => GenderizeBloc(getPrediction: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetPrediction(sl()));

  // Repository
  sl.registerLazySingleton<GenderizeRepository>(() => GenderizeRepositoryImpl(
      localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<GenderizeLocalDataSource>(
      () => GenderizeLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<GenderizeRemoteDataSource>(
      () => GenderizeRemoteDataSourceImpl(dio: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
