import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/core/usecases/usecases.dart';

void main() {
  test(
    'pastikan output dari nilai props dari class NoParams',
    () async {
      // assert
      expect(
        NoParams().props,
        [],
      );
    },
  );
}
