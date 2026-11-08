import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.phoneNumber,
    required super.firstName,
    super.lastName,
    required super.dateOfBirth,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      phoneNumber: json['phoneNumber'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String?,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      phoneNumber: user.phoneNumber,
      firstName: user.firstName,
      lastName: user.lastName,
      dateOfBirth: user.dateOfBirth,
    );
  }
}
