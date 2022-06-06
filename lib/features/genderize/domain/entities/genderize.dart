import 'package:equatable/equatable.dart';

class Genderize extends Equatable {
  final String? name;
  final String? gender;

  const Genderize({required this.name, required this.gender});

  @override
  List<Object?> get props => [name, gender];

  @override
  String toString() {
    return 'Genderize{name: $name, gender: $gender}';
  }
}
