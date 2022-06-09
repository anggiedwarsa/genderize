import 'package:genderize/features/domain/entities/nationalize/nationalize.dart';

class NationalizeModel extends Nationalize {
  const NationalizeModel({
    required String name,
    required List<Country>? countries,
  }) : super(name: name, countries: countries);

  factory NationalizeModel.fromJson(Map<String, dynamic> json) {
    return NationalizeModel(
      name: json['name'],
      countries: List<Country>.from(
        json['country'].map((data) => Country.fromJson(data)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': countries
          ?.map(
            (e) => e.toJson(),
          )
          .toList(),
    };
  }
}
