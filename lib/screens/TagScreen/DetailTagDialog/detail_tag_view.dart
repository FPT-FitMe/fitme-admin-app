import 'package:fitme_admin_app/models/tag.dart';

abstract class DetailTagView {
  void showSuccessModal(Tag tag, String message);
  void showFailedModal(String message);
}
