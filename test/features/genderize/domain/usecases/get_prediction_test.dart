import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/genderize/domain/entities/genderize.dart';
import 'package:genderize/features/genderize/domain/repositories/genderize_repository.dart';
import 'package:genderize/features/genderize/domain/usecases/get_prediction.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_prediction_test.mocks.dart';

@GenerateMocks([GenderizeRepository])
void main() {
  late MockGenderizeRepository mockGenderizeRepository;
  late GetPrediction usecase;
  late String name;
  late Genderize genderize;

  setUp(() {
    mockGenderizeRepository = MockGenderizeRepository();
    usecase = GetPrediction(mockGenderizeRepository);
    name = "Rihanna";
    genderize = Genderize(name: name, gender: 'female');
  });

  test('harus menerima prediksi gender untuk nama dari repo', () async {
    // arrange
    when(mockGenderizeRepository.getPrediction(name))
        .thenAnswer((_) async => Right(genderize));

    // act
    final result = await usecase(GenderizeParams(name: name));

    // assert
    expect(result, equals(Right(genderize)));
    verify(mockGenderizeRepository.getPrediction(name));
    verifyNoMoreInteractions(mockGenderizeRepository);
  });
}
