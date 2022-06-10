import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/core/util/string_helper.dart';
import 'package:genderize/features/data/models/genderize/genderize_model.dart';
import 'package:genderize/features/domain/usecases/genderize/get_prediction.dart';
import 'package:genderize/features/presentation/bloc/genderize/genderize_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
import '../../../../../mock_helper.mocks.dart';

void main() {
  late GenderizeBloc genderizeBloc;
  late MockGetPrediction mockGetPrediction;

  setUp(() {
    mockGetPrediction = MockGetPrediction();
    genderizeBloc = GenderizeBloc(getPrediction: mockGetPrediction);
  });

  test(
    'pastikan output dari nilai initialState',
    () async {
      // assert
      expect(genderizeBloc.state, GenderizeInitial());
    },
  );

  group('getPrediction', () {
    final genderize = GenderizeModel.fromJson(
      json.decode(
        fixture('genderize.json'),
      ),
    );
    final tName = genderize.name!;
    final tEvent = GetPredictionGender(tName);
    final tParams = GenderizeParams(name: tName);

    blocTest(
      'pastikan emit [GenderizeLoading, GenderizeLoaded] ketika terima event '
      'GetPredictionGender dengan proses berhasil',
      build: () {
        when(mockGetPrediction(any))
            .thenAnswer((_) async => Right(genderize));
        return genderizeBloc;
      },
      act: (GenderizeBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        GenderizeLoading(),
        GenderizeLoaded(genderize: genderize),
      ],
      verify: (_) async {
        verify(mockGetPrediction(tParams));
      },
    );

    blocTest(
      'pastikan emit [GenderizeLoading, GenderizeError] ketika terima event '
      'GetPredictionGender dengan proses gagal dari API',
      build: () {
        when(mockGetPrediction(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return genderizeBloc;
      },
      act: (GenderizeBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        GenderizeLoading(),
        const GenderizeError(message: StringHelper.serverFailureMessage),
      ],
      verify: (_) async {
        verify(mockGetPrediction(tParams));
      },
    );

    blocTest(
      'pastikan emit [GenderizeLoading, GenderizeError] ketika terima event '
      'GetPredictionGender dengan proses gagal ambil dari lokal',
      build: () {
        when(mockGetPrediction(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        return genderizeBloc;
      },
      act: (GenderizeBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        GenderizeLoading(),
        const GenderizeError(message: StringHelper.cacheFailureMessage),
      ],
      verify: (_) async {
        verify(mockGetPrediction(tParams));
      },
    );
  });
}
