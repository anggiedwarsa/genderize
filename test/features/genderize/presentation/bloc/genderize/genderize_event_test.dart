import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/presentation/bloc/genderize/genderize_bloc.dart';

void main() {
  group('GetPredictionGender', () {
    const tEvent = GetPredictionGender('testName');

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
          'GetPredictionGender{name: ${tEvent.name}}',
        );
      },
    );
  });
}
