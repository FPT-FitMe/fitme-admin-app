import 'package:fitme_admin_app/models/tag.dart';

abstract class TagView {
  void loadTags(List<Tag> listTags);
  void refreshTypeView(String type, List<Tag> listTags);
  void showFailedModal(String message);
  void deleteTag(Tag tag);
}
