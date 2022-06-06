import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/core/error/exceptions.dart';
import 'package:genderize/features/genderize/data/datasources/genderize_local_data_source.dart';
import 'package:genderize/features/genderize/data/models/genderize_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../mock_helper.mocks.dart';

void main() {
  late GenderizeLocalDataSourceImpl genderizeLocalDataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    genderizeLocalDataSourceImpl = GenderizeLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getPrediction', () {
    final strCacheGenderize = fixture('genderize_cache.json');
    final jsonStringCacheGenderize = json.decode(strCacheGenderize);
    final tGenderizeModel = GenderizeModel.fromJson(
      jsonStringCacheGenderize,
    );

    test(
      'pastikan ada data genderize dari lokal',
      () async {
        // arrange
        when(mockSharedPreferences.getString(cacheGenderize)).thenReturn(strCacheGenderize);

        // act
        final result = await genderizeLocalDataSourceImpl.getPrediction();

        // assert
        expect(result, tGenderizeModel);
        verify(mockSharedPreferences.getString(cacheGenderize));
      },
    );

    test(
      'pastikan akan menerima exception CacheException ketika tidak ada ada genderize dari lokal',
      () async {
        // arrange
        when(mockSharedPreferences.getString(cacheGenderize)).thenReturn(null);

        // act
        final call = genderizeLocalDataSourceImpl.getPrediction();

        // assert
        expect(() => call, throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheGender', () {
    test(
      'pastikan bisa menyimpan data GenderizeModel kedalam SharedPreferences',
      () async {
        // arrange
        final tGenderizeModel = GenderizeModel.fromJson(
          json.decode(
            fixture('genderize_cache.json'),
          ),
        );
        final jsonStringGenderizeModel = json.encode(tGenderizeModel.toJson());
        when(mockSharedPreferences.setString(cacheGenderize, jsonStringGenderizeModel)).thenAnswer((_) async => true);

        // act
        final result = await genderizeLocalDataSourceImpl.cacheGender(tGenderizeModel);

        // assert
        expect(result, true);
        verify(mockSharedPreferences.setString(cacheGenderize, jsonStringGenderizeModel));
      },
    );
  });
}
