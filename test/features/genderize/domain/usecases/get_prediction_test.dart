import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/genderize/domain/entities/genderize.dart';
import 'package:genderize/features/genderize/domain/usecases/get_prediction.dart';
import 'package:mockito/mockito.dart';

import '../../../../mock_helper.mocks.dart';

void main() {
  late MockGenderizeRepository mockGenderizeRepository;
  late GetPrediction usecase;

  setUp(() {
    mockGenderizeRepository = MockGenderizeRepository();
    usecase = GetPrediction(mockGenderizeRepository);
  });

  const tName = 'Rihanna';
  const tGenderize = Genderize(
    name: tName,
    gender: 'female',
  );
  const tParams = GenderizeParams(name: tName);

  test(
    'pastikan objek repository berhasil menerima respon dari endpoint getPrediction atau lokal',
    () async {
      // arrange
      when(mockGenderizeRepository.getPrediction(tName)).thenAnswer((_) async => const Right(tGenderize));

      // act
      final result = await usecase(tParams);

      // assert
      expect(result, const Right(tGenderize));
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
