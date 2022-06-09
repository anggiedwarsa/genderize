import 'package:dio/dio.dart';
import 'package:genderize/core/network/network_info.dart';
import 'package:genderize/features/data/datasources/genderize/genderize_local_data_source.dart';
import 'package:genderize/features/data/datasources/genderize/genderize_remote_data_source.dart';
import 'package:genderize/features/data/datasources/nationalize/nationalize_local_data_source.dart';
import 'package:genderize/features/data/datasources/nationalize/nationalize_remote_data_source.dart';
import 'package:genderize/features/domain/repositories/genderize/genderize_repository.dart';
import 'package:genderize/features/domain/repositories/nationalize/nationalize_repository.dart';
import 'package:genderize/features/domain/usecases/genderize/get_prediction.dart';
import 'package:genderize/features/domain/usecases/nationalize/get_prediction_country.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([
  SharedPreferences,
  NetworkInfo,
  InternetConnectionChecker,
  Dio,
  //Genderiz
  GetPrediction,
  GenderizeRemoteDataSource,
  GenderizeLocalDataSource,
  GenderizeRepository,
  //Nationalize
  GetPredictionCountry,
  NationalizeRemoteDataSource,
  NationalizeLocalDataSource,
  NationalizeRepository,
])
void main() {}
