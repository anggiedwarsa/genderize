import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/data/models/nationalize/nationalize_model.dart';
import 'package:genderize/features/domain/entities/nationalize/nationalize.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  const name = 'Anggi';
  const countries = <Country>[
    Country(
      countryId: 'ID',
      probability: 0.9999999999999999,
    ),
  ];
  const nationalizeModel = NationalizeModel(name: name, countries: countries);

  test(
    'pastikan apakah subclass dari Genderize entity',
    () async {
      // assert
      expect(nationalizeModel, isA<Nationalize>());
    },
  );

  group('test fungsi fromJson', () {
    test(
      'harus mengembalikan value dengan tipe model Nationalize',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('nationalize.json'));

        // act
        final result = NationalizeModel.fromJson(jsonMap);

        // assert
        expect(result, nationalizeModel);
      },
    );
  });

  group('test fungsi toJson', () {
    test(
      'harus mengembalikan data yang sama',
      () async {
        // arrange
        final expectedMap = {
          "name": "Anggi",
          "country": [
            {
              "country_id": "ID",
              "probability": 0.9999999999999999,
            }
          ]
        };

        // act
        final result = nationalizeModel.toJson();

        // assert
        expect(result, expectedMap);
      },
    );
  });
}
