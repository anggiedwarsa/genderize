import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/data/models/genderize/genderize_model.dart';
import 'package:genderize/features/presentation/bloc/genderize/genderize_bloc.dart';

import '../../../../../fixtures/fixture_reader.dart';

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
    final tGenderize = GenderizeModel.fromJson(
      json.decode(
        fixture('genderize.json'),
      ),
    );
    final tState = GenderizeLoaded(
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
