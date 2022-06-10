import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/data/models/genderize/genderize_model.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  final genderizeModel = GenderizeModel.fromJson(
    json.decode(
      fixture('genderize.json'),
    ),
  );

  test(
    'pastikan fungsi fromJson bisa mengembalikan objek class model GenderizeModel',
    () async {
      // arrange
      final jsonMap = json.decode(fixture('genderize.json'));

      // act
      final actualModel = GenderizeModel.fromJson(jsonMap);

      // assert
      expect(actualModel, genderizeModel);
    },
  );

  test(
    'pastikan fungsi toJson bisa mengembalikan objek Map',
    () async {
      // arrange
      final model = GenderizeModel.fromJson(
        json.decode(
          fixture('genderize.json'),
        ),
      );

      // act
      final actualMap = json.encode(model.toJson());

      // assert
      expect(
        actualMap,
        json.encode(
          genderizeModel.toJson(),
        ),
      );
    },
  );

  test(
    'pastikan output dari nilai props',
    () async {
      // assert
      expect(
        genderizeModel.props,
        [
          genderizeModel.name,
          genderizeModel.gender,
        ],
      );
    },
  );

  test(
    'pastikan output dari fungsi toString',
    () async {
      // assert
      expect(
        genderizeModel.toString(),
        'GenderizeModel{name: ${genderizeModel.name}, gender: ${genderizeModel.gender}}',
      );
    },
  );
}
