import 'package:json_annotation/json_annotation.dart';
part 'tag.g.dart';

@JsonSerializable()
class Tag {
  int? id;
  String name;
  String? type;

  Tag({
    this.id,
    required this.name,
    required this.type,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}
