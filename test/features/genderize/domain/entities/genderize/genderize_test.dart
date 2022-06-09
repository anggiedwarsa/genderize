import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/domain/entities/genderize/genderize.dart';

void main() {
  const tEntity = Genderize(
    name: 'testName',
    gender: 'testGender',
  );

  test(
    'pastikan output dari nilai props',
    () async {
      // assert
      expect(
        tEntity.props,
        [
          tEntity.name,
          tEntity.gender,
        ],
      );
    },
  );

  test(
    'pastikan output dari fungsi toString',
    () async {
      // assert
      expect(
        tEntity.toString(),
        'Genderize{name: ${tEntity.name}, gender: ${tEntity.gender}}',
      );
    },
  );
}
