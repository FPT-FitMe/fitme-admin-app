// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    userID: json['userID'] as int,
    username: json['username'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    age: json['age'] as int,
    gender: json['gender'] as int,
    imageUrl: json['imageUrl'] as String?,
    height: (json['height'] as num?)?.toDouble(),
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userID': instance.userID,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'age': instance.age,
      'gender': instance.gender,
      'imageUrl': instance.imageUrl,
      'height': instance.height,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
