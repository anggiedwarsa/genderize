import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/domain/entities/nationalize/nationalize.dart';
import 'package:genderize/features/domain/usecases/nationalize/get_prediction_country.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mock_helper.mocks.dart';

void main() {
  late MockNationalizeRepository mockNationalizeRepository;
  late GetPredictionCountry usecase;

  setUp(() {
    mockNationalizeRepository = MockNationalizeRepository();
    usecase = GetPredictionCountry(mockNationalizeRepository);
  });

  const tName = 'Anggi';
  const tCountries = <Country>[
    Country(
      countryId: 'ID',
      probability: 0.9999999999999999,
    ),
  ];
  const tNationalize = Nationalize(name: tName, countries: tCountries);

  const tParams = NationalizeParams(name: tName);

  test(
    'pastikan objek repository berhasil menerima respon dari endpoint getPredictionCountry atau lokal',
    () async {
      // arrange
      when(mockNationalizeRepository.getPredictionCountry(tName))
          .thenAnswer((_) async => const Right(tNationalize));

      // act
      final result = await usecase(tParams);

      // assert
      expect(result, const Right(tNationalize));
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
