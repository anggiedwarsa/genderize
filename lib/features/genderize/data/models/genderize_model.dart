import 'package:genderize/features/genderize/domain/entities/genderize.dart';

class GenderizeModel extends Genderize {
  GenderizeModel({required super.name, required super.gender});

  factory GenderizeModel.fromJson(Map<String, dynamic> json) {
    return GenderizeModel(name: json['name'], gender: json['gender']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'gender': gender};
  }
}
