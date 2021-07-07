import 'package:fitme_admin_app/models/tag.dart';

abstract class TagRepository {
  Future<List<Tag>> getAllTags();
  Future<List<Tag>> getTagByType(String type);
  Future<Tag> addTag(Tag tag);
  Future<Tag> updateTag(Tag tag);
  Future<int?> disableTag(int tagID);
}
