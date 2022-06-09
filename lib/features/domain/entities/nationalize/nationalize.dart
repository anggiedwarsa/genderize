import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Nationalize extends Equatable {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'countries')
  final List<Country>? countries;

  const Nationalize({
    required this.name,
    required this.countries,
  });

  @override
  List<Object?> get props => [name, countries];

  @override
  String toString() {
    return 'Nationalize{name: $name, countries: $countries}';
  }
}

@JsonSerializable()
class Country extends Equatable {
  @JsonKey(name: 'country_id')
  final String countryId;
  @JsonKey(name: 'probability')
  final double probability;

  const Country({
    required this.countryId,
    required this.probability,
  });
  @override
  List<Object?> get props => [countryId, probability];

  @override
  String toString() {
    return 'Country{countryId: $countryId, probability: $probability}';
  }

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryId: json['country_id'],
      probability: json['probability'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country_id': countryId,
      'probability': probability,
    };
  }
}
