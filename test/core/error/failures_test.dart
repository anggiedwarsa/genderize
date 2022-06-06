import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/core/error/failures.dart';

void main() {
  group('ServerFailure', () {
    final tFailure = ServerFailure();

    test(
      'pastikan output dari nilai props',
      () async {
        // assert
        expect(
          tFailure.props,
          [],
        );
      },
    );

    test(
      'pastikan output dari fungsi toString',
      () async {
        // assert
        expect(
          tFailure.toString(),
          'ServerFailure()',
        );
      },
    );
  });

  group('CacheFailure', () {
    final tFailure = CacheFailure();

    test(
      'pastikan output dari nilai props',
      () async {
        // assert
        expect(
          tFailure.props,
          [],
        );
      },
    );

    test(
      'pastikan output dari fungsi toString',
      () async {
        // assert
        expect(
          tFailure.toString(),
          'CacheFailure()',
        );
      },
    );
  });

  group('ConnectionFailure', () {
    final tFailure = ConnectionFailure();

    test(
      'pastikan output dari nilai props',
      () async {
        // assert
        expect(
          tFailure.props,
          [
            tFailure.errorMessage,
          ],
        );
      },
    );

    test(
      'pastikan output dari fungsi toString',
      () async {
        // assert
        expect(
          tFailure.toString(),
          'ConnectionFailure{errorMessage: ${tFailure.errorMessage}}',
        );
      },
    );
  });
}
