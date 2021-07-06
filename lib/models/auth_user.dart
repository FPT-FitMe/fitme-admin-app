import 'package:json_annotation/json_annotation.dart';
part 'auth_user.g.dart';

@JsonSerializable()
class AuthUser {
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String role;
  final String phoneNumber;
  final String profileImageUrl;
  final bool? premium;

  AuthUser({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.role,
    required this.phoneNumber,
    required this.profileImageUrl,
    this.premium,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
  Map<String, dynamic> toJson() => _$AuthUserToJson(this);
}
