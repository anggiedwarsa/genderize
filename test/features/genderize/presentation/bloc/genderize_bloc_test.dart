import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/genderize/domain/entities/genderize.dart';
import 'package:genderize/features/genderize/domain/usecases/get_prediction.dart';
import 'package:genderize/features/genderize/presentation/bloc/genderize_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'genderize_bloc_test.mocks.dart';

@GenerateMocks([GetPrediction])
void main() {
  late GenderizeBloc genderizeBloc;
  late MockGetPrediction mockGetPrediction;

  setUp(() {
    mockGetPrediction = MockGetPrediction();
    genderizeBloc = GenderizeBloc(getPrediction: mockGetPrediction);
  });

  test('initialState harus GenderizeInitial', () async {
    // assert
    expect(genderizeBloc.initialState, equals(GenderizeInitial()));
  });

  group('getPrediction', () {
    final genderize = Genderize(name: 'Rihanna', gender: 'female');
    test(
        'harus emit [GenderizeLoading, GenderizeLoaded] ketika data berhasil diterima',
        () async* {
      // arrange
      when(mockGetPrediction(any)).thenAnswer((_) async => Right(genderize));

      // assert later
      final expected = [
        GenderizeInitial(),
        GenderizeLoading(),
        GenderizeLoaded(genderize: genderize)
      ];
      expectLater(genderizeBloc, emitsInOrder(expected));

      // act
      genderizeBloc.add(GetPredictionGender(genderize.name));
    });

    test(
        'harus emit [GenderizeLoading, GenderizeError] ketika data gagal mendapatkan data',
        () async* {
      // arrange
      when(mockGetPrediction(any)).thenAnswer((_) async => Right(genderize));

      // assert later
      final expected = [
        GenderizeInitial(),
        GenderizeLoading(),
        GenderizeError(message: serverFailureMessage)
      ];
      expectLater(genderizeBloc, emitsInOrder(expected));

      // act
      genderizeBloc.add(GetPredictionGender(genderize.name));
    });

    test(
        'harus emit [GenderizeLoading, GenderizeError] ketika prediksi adalah null',
        () async* {
      // arrange
      when(mockGetPrediction(any)).thenAnswer((_) async => Right(genderize));

      // assert later
      final expected = [
        GenderizeInitial(),
        GenderizeLoading(),
        GenderizeError(message: failedPredictionMessage)
      ];
      expectLater(genderizeBloc, emitsInOrder(expected));

      // act
      genderizeBloc.add(GetPredictionGender(genderize.name));
    });
  });
}
