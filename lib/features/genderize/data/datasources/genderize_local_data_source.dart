import 'dart:convert';

import 'package:genderize/core/error/exceptions.dart';
import 'package:genderize/features/genderize/data/models/genderize_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GenderizeLocalDataSource {
  Future<GenderizeModel>? getPrediction();
  Future<void>? cacheGender(GenderizeModel genderToCache);
}

const cacheGenderize = 'CACHE_GENDERIZE';

class GenderizeLocalDataSourceImpl implements GenderizeLocalDataSource {
  final SharedPreferences sharedPreferences;

  GenderizeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<GenderizeModel>? getPrediction() {
    final jsonString = sharedPreferences.getString(cacheGenderize);
    if (jsonString != null) {
      return Future.value(GenderizeModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheGender(GenderizeModel genderToCache) {
    return sharedPreferences.setString(
        cacheGenderize, json.encode(genderToCache.toJson()));
  }
}
