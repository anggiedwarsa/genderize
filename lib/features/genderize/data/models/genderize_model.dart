import 'package:genderize/features/genderize/domain/entities/genderize.dart';

class GenderizeModel extends Genderize {
  GenderizeModel({required String name, required String gender})
      : super(name: name, gender: gender);

  factory GenderizeModel.fromJson(Map<String, dynamic> json) {
    return GenderizeModel(name: json['name'], gender: json['gender']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'gender': gender};
  }
}
