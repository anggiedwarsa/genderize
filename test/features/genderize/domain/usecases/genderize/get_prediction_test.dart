import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/data/models/genderize/genderize_model.dart';
import 'package:genderize/features/domain/usecases/genderize/get_prediction.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
import '../../../../../mock_helper.mocks.dart';

void main() {
  late MockGenderizeRepository mockGenderizeRepository;
  late GetPrediction usecase;

  setUp(() {
    mockGenderizeRepository = MockGenderizeRepository();
    usecase = GetPrediction(mockGenderizeRepository);
  });

  const tName = 'Rihanna';
  final tResponse = GenderizeModel.fromJson(
    json.decode(
      fixture('genderize.json'),
    ),
  );
  const tParams = GenderizeParams(name: tName);

  test(
    'pastikan objek repository berhasil menerima respon dari endpoint getPrediction atau lokal',
    () async {
      // arrange
      when(mockGenderizeRepository.getPrediction(tName))
          .thenAnswer((_) async => Right(tResponse));

      // act
      final result = await usecase(tParams);

      // assert
      expect(result, Right(tResponse));
      verify(mockGenderizeRepository.getPrediction(tName));
      verifyNoMoreInteractions(mockGenderizeRepository);
    },
  );

  test(
    'pastikan output dari nilai props class GenderizeParams',
    () async {
      // assert
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
      // assert
      expect(
        tParams.toString(),
        'GenderizeParams{name: ${tParams.name}}',
      );
    },
  );
}
