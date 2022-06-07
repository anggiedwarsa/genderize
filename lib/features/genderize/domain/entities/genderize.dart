import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Genderize extends Equatable {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'gender')
  final String? gender;

  const Genderize({required this.name, required this.gender});

  @override
  List<Object?> get props => [name, gender];

  @override
  String toString() {
    return 'Genderize{name: $name, gender: $gender}';
  }
}
