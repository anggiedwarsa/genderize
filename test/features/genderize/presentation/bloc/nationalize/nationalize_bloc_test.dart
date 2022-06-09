import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/core/util/string_helper.dart';
import 'package:genderize/features/domain/entities/nationalize/nationalize.dart';
import 'package:genderize/features/domain/usecases/nationalize/get_prediction_country.dart';
import 'package:genderize/features/presentation/bloc/nationalize/nationalize_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mock_helper.mocks.dart';

void main() {
  late NationalizeBloc nationalizeBloc;
  late MockGetPredictionCountry mockGetPredictionCountry;

  setUp(() {
    mockGetPredictionCountry = MockGetPredictionCountry();
    nationalizeBloc =
        NationalizeBloc(getPredictionCountry: mockGetPredictionCountry);
  });

  test(
    'pastikan output dari nilai initialState',
    () async {
      // assert
      expect(nationalizeBloc.state, NationalizeInitial());
    },
  );

  group('getPredictionCountry', () {
    const tName = 'Anggi';
    const tCountries = <Country>[
      Country(
        countryId: 'ID',
        probability: 0.9999999999999999,
      ),
    ];
    const tNationalize = Nationalize(
      name: tName,
      countries: tCountries,
    );
    const tEvent = PredictCountryByName(name: tName);
    const tParams = NationalizeParams(name: tName);

    blocTest(
      'pastikan emit [NationalizeLoading, NationalizeLoaded] ketika terima event '
      'PredictCountryByName dengan proses berhasil',
      build: () {
        when(mockGetPredictionCountry(any))
            .thenAnswer((_) async => const Right(tNationalize));
        return nationalizeBloc;
      },
      act: (NationalizeBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        NationalizeLoading(),
        const NationalizeLoaded(nationalize: tNationalize),
      ],
      verify: (_) async {
        verify(mockGetPredictionCountry(tParams));
      },
    );

    blocTest(
      'pastikan emit [NationalizeLoading, NationalizeError] ketika terima event '
      'PredictCountryByName dengan proses gagal dari API',
      build: () {
        when(mockGetPredictionCountry(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return nationalizeBloc;
      },
      act: (NationalizeBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        NationalizeLoading(),
        const NationalizeError(message: StringHelper.serverFailureMessage),
      ],
      verify: (_) async {
        verify(mockGetPredictionCountry(tParams));
      },
    );

    blocTest(
      'pastikan emit [NationalizeLoading, NationalizeError] ketika terima event '
      'PredictCountryByName dengan proses gagal ambil dari lokal',
      build: () {
        when(mockGetPredictionCountry(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        return nationalizeBloc;
      },
      act: (NationalizeBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        NationalizeLoading(),
        const NationalizeError(message: StringHelper.cacheFailureMessage),
      ],
      verify: (_) async {
        verify(mockGetPredictionCountry(tParams));
      },
    );
  });
}
