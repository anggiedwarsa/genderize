import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genderize_model.g.dart';

@JsonSerializable()
class GenderizeModel extends Equatable {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'gender')
  final String? gender;

  const GenderizeModel({
    required this.name,
    required this.gender,
  });

  factory GenderizeModel.fromJson(Map<String, dynamic> json) => _$GenderizeModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenderizeModelToJson(this);

  @override
  List<Object?> get props => [
    name,
    gender,
  ];

  @override
  String toString() {
    return 'GenderizeModel{name: $name, gender: $gender}';
  }
}
