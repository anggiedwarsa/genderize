import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/domain/entities/genderize/genderize.dart';
import 'package:genderize/features/presentation/bloc/genderize/genderize_bloc.dart';

void main() {
  group('GenderizeInitial', () {
    final tState = GenderizeInitial();

    test(
      'pastikan output dari nilai props',
      () async {
        // assert
        expect(
          tState.props,
          [],
        );
      },
    );

    test(
      'pastikan output dari fungsi toString',
      () async {
        // assert
        expect(
          tState.toString(),
          'GenderizeInitial()',
        );
      },
    );
  });

  group('GenderizeLoading', () {
    final tState = GenderizeLoading();

    test(
      'pastikan output dari nilai props',
      () async {
        // assert
        expect(
          tState.props,
          [],
        );
      },
    );

    test(
      'pastikan output dari fungsi toString',
      () async {
        // assert
        expect(
          tState.toString(),
          'GenderizeLoading()',
        );
      },
    );
  });

  group('GenderizeLoaded', () {
    const tGenderize = Genderize(
      name: 'testName',
      gender: 'testGender',
    );
    const tState = GenderizeLoaded(
      genderize: tGenderize,
    );

    test(
      'pastikan output dari nilai props',
      () async {
        // assert
        expect(
          tState.props,
          [
            tState.genderize,
          ],
        );
      },
    );

    test(
      'pastikan output dari fungsi toString',
      () async {
        // assert
        expect(
          tState.toString(),
          'GenderizeLoaded{genderize: ${tState.genderize}}',
        );
      },
    );
  });

  group('GenderizeError', () {
    const tState = GenderizeError(message: 'testMessage');

    test(
      'pastikan output dari nilai props',
      () async {
        // assert
        expect(
          tState.props,
          [
            tState.message,
          ],
        );
      },
    );

    test(
      'pastikan output dari fungsi toString',
      () async {
        // assert
        expect(
          tState.toString(),
          'GenderizeError{message: ${tState.message}}',
        );
      },
    );
  });
}
