// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    userID: json['userID'] as int?,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String,
    age: json['age'] as int?,
    phone: json['phone'] as String?,
    profileImageUrl: json['profileImageUrl'] as String?,
    premium: json['premium'] as bool?,
    height: (json['height'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userID': instance.userID,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'age': instance.age,
      'phone': instance.phone,
      'profileImageUrl': instance.profileImageUrl,
      'height': instance.height,
      'premium': instance.premium,
    };
