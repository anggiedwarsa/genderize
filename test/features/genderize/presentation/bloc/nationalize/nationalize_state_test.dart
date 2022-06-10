import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/data/models/nationalize/nationalize_model.dart';
import 'package:genderize/features/presentation/bloc/nationalize/nationalize_bloc.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  group('nationalizeInitial', () {
    final tState = NationalizeInitial();

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
          'NationalizeInitial()',
        );
      },
    );
  });

  group('NationalizeLoading', () {
    final tState = NationalizeLoading();

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
          'NationalizeLoading()',
        );
      },
    );
  });

  group('NationalizeLoaded', () {
    final tNationalize = NationalizeModel.fromJson(
      json.decode(
        fixture('nationalize.json'),
      ),
    );
    final tState = NationalizeLoaded(
      nationalize: tNationalize,
    );

    test(
      'pastikan output dari nilai props',
      () async {
        // assert
        expect(
          tState.props,
          [
            tState.nationalize,
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
          'NationalizeLoaded{nationalize: ${tState.nationalize}}',
        );
      },
    );
  });

  group('NationalizeError', () {
    const tState = NationalizeError(message: 'testMessage');

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
          'NationalizeError{message: ${tState.message}}',
        );
      },
    );
  });
}
