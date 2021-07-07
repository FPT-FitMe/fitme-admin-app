import 'package:fitme_admin_app/models/coach.dart';

abstract class CoachView {
  void loadCoaches(List<Coach> listCoaches);
  void refresh();
  void showFailedModal(String message);
  void showEmptyList();
}
