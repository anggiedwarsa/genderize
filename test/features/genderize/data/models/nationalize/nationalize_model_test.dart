import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/data/models/nationalize/nationalize_model.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  final nationalizeModel = NationalizeModel.fromJson(
    json.decode(
      fixture('nationalize.json'),
    ),
  );

  test(
    'pastikan fungsi fromJson bisa mmengembalikan class model NationalizeModel',
    () async {
      // arrange
      final jsonMap = json.decode(fixture('nationalize.json'));

      // act
      final actualModel = NationalizeModel.fromJson(jsonMap);

      // assert
      expect(actualModel, nationalizeModel);
    },
  );

  test(
    'pastikan fungsi toJson bisa mengembalikan objek Map',
    () async {
      // arrange
      final model = NationalizeModel.fromJson(
        json.decode(
          fixture('nationalize.json'),
        ),
      );

      // act
      final actualMap = json.encode(model.toJson());

      // assert
      expect(
        actualMap,
        json.encode(
          nationalizeModel.toJson(),
        ),
      );
    },
  );

  test(
    'pastikan output dari nilai props',
    () async {
      // assert
      expect(
        nationalizeModel.props,
        [
          nationalizeModel.name,
          nationalizeModel.countries,
        ],
      );
    },
  );

  test(
    'pastikan output dari fungsi toString',
    () async {
      // assert
      expect(
        nationalizeModel.toString(),
        'NationalizeModel{name: ${nationalizeModel.name}, countries: ${nationalizeModel.countries}}',
      );
    },
  );
}
