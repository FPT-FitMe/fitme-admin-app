import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/tag.dart';
import 'package:fitme_admin_app/repository/tag_repository.dart';
import 'package:fitme_admin_app/screens/TagScreen/DetailTagDialog/detail_tag_view.dart';

class DetailTagPresenter {
  DetailTagView _detailTagView;
  late TagRepository _tagRepository;

  DetailTagPresenter(this._detailTagView) {
    _tagRepository = new Injector().tagRepository;
  }

  void addTag(Tag tag) async {
    try {
      Tag addedTag = await _tagRepository.addTag(tag);
      _detailTagView.showSuccessModal(
          addedTag, "Thêm ${addedTag.name} thành công");
    } catch (e) {
      _detailTagView.showFailedModal("Lỗi đã xảy ra khi thêm tag");
      print(e);
    }
  }

  void updateTag(Tag tag) async {
    try {
      Tag updatedTag = await _tagRepository.updateTag(tag);
      _detailTagView.showSuccessModal(
          updatedTag, "Cập nhật ${updatedTag.name} thành công");
    } catch (e) {
      _detailTagView.showFailedModal("Lỗi đã xảy ra khi cập nhật tag");
      print(e);
    }
  }
}
