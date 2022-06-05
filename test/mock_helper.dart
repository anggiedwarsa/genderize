import 'package:genderize/core/network/network_info.dart';
import 'package:genderize/features/genderize/data/datasources/genderize_local_data_source.dart';
import 'package:genderize/features/genderize/data/datasources/genderize_remote_data_source.dart';
import 'package:genderize/features/genderize/domain/repositories/genderize_repository.dart';
import 'package:genderize/features/genderize/domain/usecases/get_prediction.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([
  SharedPreferences,
  GetPrediction,
  NetworkInfo,
  GenderizeRemoteDataSource,
  GenderizeLocalDataSource,
  GenderizeRepository,
  InternetConnectionChecker,
])
void main() {}