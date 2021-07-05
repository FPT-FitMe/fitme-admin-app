import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final int? userID;
  final String firstName;
  final String lastName;
  final String email;
  final int? age;
  final String gender;
  final String role;
  final String phoneNumber;
  final String? profileImageUrl;
  final double? height;
  final bool? premium;

  User({
    this.userID,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.age,
    required this.gender,
    required this.role,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.premium,
    this.height,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
