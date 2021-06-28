import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  int userID;
  String username;
  String email;
  String phone;
  int age;
  int gender;
  String? imageUrl;
  double? height;
  String? firstName;
  String? lastName;

  User(
      {required this.userID,
      required this.username,
      required this.email,
      required this.phone,
      required this.age,
      required this.gender,
      this.imageUrl,
      this.height,
      this.firstName,
      this.lastName});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
