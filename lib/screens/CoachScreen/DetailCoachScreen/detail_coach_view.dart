import 'package:fitme_admin_app/models/coach.dart';

abstract class DetailCoachView {
  void showSuccessModal(Coach coach, String message);
  void updateImageUrl(String? imageUrl);
  void showFailedModal(String message);
  void backToCoachScreen(int? deletedCoachID);
}
