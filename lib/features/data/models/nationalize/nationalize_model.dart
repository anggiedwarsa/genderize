import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nationalize_model.g.dart';

@JsonSerializable()
class NationalizeModel extends Equatable {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'country')
  final List<Country>? countries;

  const NationalizeModel({
    required this.name,
    required this.countries,
  });

  factory NationalizeModel.fromJson(Map<String, dynamic> json) => _$NationalizeModelFromJson(json);

  Map<String, dynamic> toJson() => _$NationalizeModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        countries,
      ];

  @override
  String toString() {
    return 'NationalizeModel{name: $name, countries: $countries}';
  }
}

@JsonSerializable()
class Country extends Equatable {
  @JsonKey(name: 'country_id')
  final String? countryId;
  @JsonKey(name: 'probability')
  final double? probability;

  const Country({
    required this.countryId,
    required this.probability,
  });

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  List<Object?> get props => [
    countryId,
    probability,
  ];

  @override
  String toString() {
    return 'Country{countryId: $countryId, probability: $probability}';
  }
}
