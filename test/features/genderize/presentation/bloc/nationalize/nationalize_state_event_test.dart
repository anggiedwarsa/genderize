import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/domain/entities/nationalize/nationalize.dart';
import 'package:genderize/features/presentation/bloc/nationalize/nationalize_bloc.dart';

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
    const tCountries = <Country>[
      Country(
        countryId: 'ID',
        probability: 0.9999999999999999,
      ),
    ];
    const tNationalize = Nationalize(
      name: 'Anggi',
      countries: tCountries,
    );
    const tState = NationalizeLoaded(
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
