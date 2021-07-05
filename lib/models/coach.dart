import 'package:json_annotation/json_annotation.dart';
part 'coach.g.dart';

@JsonSerializable()
class Coach {
  int coachID;
  String name;
  String contact;
  String introduction;
  String imageUrl;

  Coach({
    required this.coachID,
    required this.name,
    required this.contact,
    required this.introduction,
    this.imageUrl =
        "https://images.unsplash.com/photo-1518617840859-acd542e13a99?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=949&q=80",
  });

  factory Coach.fromJson(Map<String, dynamic> json) => _$CoachFromJson(json);
  Map<String, dynamic> toJson() => _$CoachToJson(this);
}
