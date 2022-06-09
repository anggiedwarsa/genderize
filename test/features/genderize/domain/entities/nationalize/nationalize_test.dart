import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/domain/entities/nationalize/nationalize.dart';

void main() {
  const tCountries = <Country>[
    Country(
      countryId: 'ID',
      probability: 0.9999999999999999,
    ),
  ];
  const tNationalize = Nationalize(name: 'Anggi', countries: tCountries);

  test(
    'pastikan output dari nilai props',
    () async {
      expect(
        tNationalize.props,
        [
          tNationalize.name,
          tNationalize.countries,
        ],
      );
    },
  );

  test(
    'pastikan output dari toString',
    () {
      expect(
        tNationalize.toString(),
        'Nationalize{name: ${tNationalize.name}, countries: ${tNationalize.countries}}',
      );
    },
  );
}
