import 'dart:convert';

import 'package:genderize/core/error/exceptions.dart';
import 'package:genderize/core/util/shared_preferences_manager.dart';
import 'package:genderize/features/data/models/genderize/genderize_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GenderizeLocalDataSource {
  Future<GenderizeModel?> getPrediction();

  Future<bool> cacheGender(GenderizeModel genderToCache);
}

class GenderizeLocalDataSourceImpl implements GenderizeLocalDataSource {
  final SharedPreferences sharedPreferences;

  GenderizeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<GenderizeModel?> getPrediction() async {
    final jsonString =
        sharedPreferences.getString(SharedPreferenceManager.keyCacheGenderize);
    if (jsonString != null) {
      final jsonData = json.decode(jsonString);
      final data = GenderizeModel.fromJson(jsonData);
      return data;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> cacheGender(GenderizeModel genderToCache) {
    return sharedPreferences.setString(
        SharedPreferenceManager.keyCacheGenderize,
        json.encode(genderToCache.toJson()));
  }
}
