import 'package:fitme_admin_app/models/coach.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

@JsonSerializable()
class Post {
  final int postID;
  final String contentBody;
  final String contentHeader;
  final String imageUrl;
  final String postName;
  final int readingTime;
  final bool isActive;
  final DateTime createdDate;
  final DateTime lastUpdatedDate;
  final Coach coachProfile;

  Post({
    required this.postID,
    required this.contentBody,
    required this.contentHeader,
    required this.imageUrl,
    required this.readingTime,
    required this.isActive,
    required this.postName,
    required this.coachProfile,
    required this.createdDate,
    required this.lastUpdatedDate,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
