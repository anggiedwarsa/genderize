import 'dart:convert';

import 'package:genderize/core/error/exceptions.dart';
import 'package:genderize/core/util/shared_preferences_manager.dart';
import 'package:genderize/features/data/models/nationalize/nationalize_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NationalizeLocalDataSource {
  Future<NationalizeModel?> getPredictionCountry();

  Future<bool> cacheCountry(NationalizeModel countryToCache);
}

class NationalizeLocalDataSourceImpl implements NationalizeLocalDataSource {
  final SharedPreferences sharedPreferences;

  NationalizeLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<bool> cacheCountry(NationalizeModel countryToCache) {
    return sharedPreferences.setString(
        SharedPreferenceManager.keyCacheNationalize,
        json.encode(countryToCache.toJson()));
  }

  @override
  Future<NationalizeModel?> getPredictionCountry() async {
    final jsonString = sharedPreferences
        .getString(SharedPreferenceManager.keyCacheNationalize);
    if (jsonString != null) {
      final jsonData = json.decode(jsonString);
      final data = NationalizeModel.fromJson(jsonData);
      return data;
    } else {
      throw CacheException();
    }
  }
}
