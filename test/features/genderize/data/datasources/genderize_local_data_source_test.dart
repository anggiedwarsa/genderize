import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/genderize/data/datasources/genderize_local_data_source.dart';
import 'package:genderize/features/genderize/data/models/genderize_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'genderize_local_data_source_test.mocks.dart';

@GenerateMocks([
  SharedPreferences
], customMocks: [
  MockSpec<SharedPreferences>(
      as: #MockSharedPreferencesForTest, returnNullOnMissingStub: true)
])
void main() {
  late GenderizeLocalDataSourceImpl genderizeLocalDataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    genderizeLocalDataSourceImpl =
        GenderizeLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('dapatkan prediksi gender terakhir', () {
    final genderizeModel =
        GenderizeModel.fromJson(json.decode(fixture('genderize_cache.json')));

    test('periksa apakah ada data di SharedPreferences', () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('genderize_cache.json'));

      // act
      final result = await genderizeLocalDataSourceImpl.getPrediction();

      // assert
      verify(mockSharedPreferences.getString(cacheGenderize));
      expect(result, genderizeModel);
    });
  });

  group('simpan cache Genderize', () {
    final genderizeModel = GenderizeModel(name: 'Rihanna', gender: 'Female');
    test('harus berhasil menyimpan data ke sharedpreference', () async {
      // arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      //act
      genderizeLocalDataSourceImpl.cacheGender(genderizeModel);

      // assert
      final expectedJsonString = json.encode(genderizeModel.toJson());
      verify(mockSharedPreferences.setString(
          cacheGenderize, expectedJsonString));
    });
  });
}
