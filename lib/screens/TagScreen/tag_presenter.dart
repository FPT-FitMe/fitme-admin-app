import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/tag.dart';
import 'package:fitme_admin_app/repository/tag_repository.dart';
import 'package:fitme_admin_app/screens/TagScreen/tag_view.dart';

class TagPresenter {
  TagView _tagView;
  late TagRepository _tagRepository;

  TagPresenter(this._tagView) {
    _tagRepository = new Injector().tagRepository;
  }

  void loadAllTags() async {
    try {
      List<Tag> listTags = await _tagRepository.getAllTags();
      _tagView.loadTags(listTags);
    } catch (e) {
      print(e);
    }
  }

  void loadTagsByType(String type) async {
    try {
      List<Tag> listTags = await _tagRepository.getTagByType(type);
      _tagView.refreshTypeView(type, listTags);
    } catch (e) {
      print(e);
    }
  }

  void deleteTag(Tag tag) async {
    try {
      await _tagRepository.disableTag(int.parse(tag.id.toString()));
      _tagView.deleteTag(tag);
    } catch (e) {
      print(e);
    }
  }
}
