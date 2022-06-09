import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/data/models/genderize/genderize_model.dart';
import 'package:genderize/features/domain/entities/genderize/genderize.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  const genderizeModel = GenderizeModel(
    name: 'Rihanna',
    gender: 'female',
  );

  test(
    'pastikan apakah subclass dari Genderize entity',
    () async {
      // assert
      expect(genderizeModel, isA<Genderize>());
    },
  );

  group('test fungsi fromJson', () {
    test(
      'harus mengembalikan value dengan tipe model Genderize',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('genderize.json'));

        // act
        final result = GenderizeModel.fromJson(jsonMap);

        // assert
        expect(result, genderizeModel);
      },
    );
  });

  group('test fungsi toJson', () {
    test(
      'harus mengembalikan data yang sama',
      () async {
        // arrange
        final expectedMap = {
          "name": "Rihanna",
          "gender": "female",
        };

        // act
        final result = genderizeModel.toJson();

        // assert
        expect(result, expectedMap);
      },
    );
  });
}
