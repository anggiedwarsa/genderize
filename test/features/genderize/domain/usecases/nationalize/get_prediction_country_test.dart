import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/data/models/nationalize/nationalize_model.dart';
import 'package:genderize/features/domain/usecases/nationalize/get_prediction_country.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
import '../../../../../mock_helper.mocks.dart';

void main() {
  late MockNationalizeRepository mockNationalizeRepository;
  late GetPredictionCountry usecase;

  setUp(() {
    mockNationalizeRepository = MockNationalizeRepository();
    usecase = GetPredictionCountry(mockNationalizeRepository);
  });

  const tName = 'Anggi';
  final tResponse = NationalizeModel.fromJson(
    json.decode(
      fixture('nationalize.json'),
    ),
  );

  const tParams = NationalizeParams(name: tName);

  test(
    'pastikan objek repository berhasil menerima respon dari endpoint getPredictionCountry atau lokal',
    () async {
      // arrange
      when(mockNationalizeRepository.getPredictionCountry(tName))
          .thenAnswer((_) async => Right(tResponse));

      // act
      final result = await usecase(tParams);

      // assert
      expect(result, Right(tResponse));
      verify(mockNationalizeRepository.getPredictionCountry(tName));
      verifyNoMoreInteractions(mockNationalizeRepository);
    },
  );

  test(
    'pastikan output dari nilai props class NationalizeParams',
    () async {
      expect(
        tParams.props,
        [
          tParams.name,
        ],
      );
    },
  );

  test(
    'pastikan output dari fungsi toString',
    () async {
      expect(
        tParams.toString(),
        'NationalizeParams{name: ${tParams.name}}',
      );
    },
  );
}
