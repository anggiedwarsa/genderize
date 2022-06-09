import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/core/error/exceptions.dart';
import 'package:genderize/core/util/shared_preferences_manager.dart';
import 'package:genderize/features/data/datasources/nationalize/nationalize_local_data_source.dart';
import 'package:genderize/features/data/models/nationalize/nationalize_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
import '../../../../../mock_helper.mocks.dart';

void main() {
  late NationalizeLocalDataSourceImpl nationalizeLocalDataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    nationalizeLocalDataSourceImpl = NationalizeLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getPredictionCountry', () {
    final strCache = fixture('nationalize.json');
    final jsonStringCache = json.decode(strCache);
    final tNationalizeModel = NationalizeModel.fromJson(
      jsonStringCache,
    );

    test(
      'pasti ada data nationalize dari lokal',
      () async {
        // arrange
        when(mockSharedPreferences
                .getString(SharedPreferenceManager.keyCacheNationalize))
            .thenReturn(strCache);

        // act
        final result =
            await nationalizeLocalDataSourceImpl.getPredictionCountry();

        // assert
        expect(result, tNationalizeModel);
        verify(mockSharedPreferences
            .getString(SharedPreferenceManager.keyCacheNationalize));
      },
    );

    test(
      'pastikan akan menerima exception CacheException ketika tidak ada ada genderize dari lokal',
      () async {
        // arrange
        when(mockSharedPreferences
                .getString(SharedPreferenceManager.keyCacheNationalize))
            .thenReturn(null);

        // act
        final call = nationalizeLocalDataSourceImpl.getPredictionCountry();

        // assert
        expect(() => call, throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheGenderize', () {
    test(
      'pastikan bisa menyimpan data NationalizeModel kedalam SharedPreferences',
      () async {
        // arrange
        final tNationalizeModel = NationalizeModel.fromJson(
          json.decode(
            fixture('nationalize.json'),
          ),
        );
        final jsonStringNationalizeModel =
            json.encode(tNationalizeModel.toJson());
        when(mockSharedPreferences.setString(
                SharedPreferenceManager.keyCacheNationalize,
                jsonStringNationalizeModel))
            .thenAnswer((_) async => true);

        // act
        final result = await nationalizeLocalDataSourceImpl
            .cacheCountry(tNationalizeModel);

        // assert
        expect(result, true);
        verify(mockSharedPreferences.setString(
            SharedPreferenceManager.keyCacheNationalize,
            jsonStringNationalizeModel));
      },
    );
  });
}
