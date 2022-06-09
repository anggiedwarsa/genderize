import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/presentation/bloc/nationalize/nationalize_bloc.dart';

void main() {
  group('PredictNameByCountry', () {
    const tEvent = PredictCountryByName(name: 'testName');

    test(
      'pastikan output dari nilai props',
      () async {
        // assert
        expect(
          tEvent.props,
          [
            tEvent.name,
          ],
        );
      },
    );

    test(
      'pastikan output dari fungsi toString',
      () async {
        // assert
        expect(
          tEvent.toString(),
          'PredictCountryByName{name: ${tEvent.name}}',
        );
      },
    );
  });
}
