import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/repository/coach_repository.dart';
import 'package:fitme_admin_app/repository/image_repository.dart';
import 'package:fitme_admin_app/screens/CoachScreen/DetailCoachScreen/detail_coach_view.dart';

class DetailCoachPresenter {
  DetailCoachView _detailCoachView;
  late CoachRepository _coachRepository;
  late ImageRepository _imageRepository;

  DetailCoachPresenter(this._detailCoachView) {
    _coachRepository = new Injector().coachRepository;
    _imageRepository = new Injector().coachImageRepository;
  }

  void uploadImage(String imagePath) async {
    try {
      String? imageUrl = await _imageRepository.uploadImage(imagePath);
      _detailCoachView.updateImageUrl(imageUrl);
    } catch (e) {
      print(e);
      _detailCoachView.showFailedModal("Lỗi khi upload ảnh");
    }
  }

  void addCoach(Coach coach) async {
    try {
      Coach addedCoach = await _coachRepository.addCoach(coach);
      _detailCoachView.showSuccessModal(
          addedCoach, "Thêm ${coach.name} thành công");
    } catch (e) {
      print(e);
      _detailCoachView.showFailedModal("Lỗi khi thêm huấn luyên viên");
    }
  }

  void updateCoach(Coach coach) async {
    try {
      Coach updatedCoach = await _coachRepository.updateCoach(coach);
      _detailCoachView.showSuccessModal(
          updatedCoach, "Cập nhật ${coach.name} thành công");
    } catch (e) {
      print(e);
    }
  }

  void deleteCoach(int id) async {
    try {
      int? deletedCoachID = await _coachRepository.disableCoach(id);
      _detailCoachView.backToCoachScreen(deletedCoachID);
    } catch (e) {
      print(e);
    }
  }
}
