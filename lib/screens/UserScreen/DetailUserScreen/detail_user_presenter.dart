import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/repository/user_repository.dart';
import 'package:fitme_admin_app/screens/UserScreen/DetailUserScreen/detail_user_view.dart';

class DetailUserPresenter {
  DetailUserView _detailUserView;
  late UserRepository _userRepository;

  DetailUserPresenter(this._detailUserView) {
    _userRepository = new Injector().userRepository;
  }

  void disableUser(int id) async {
    try {
      await _userRepository.disableUser(id);
      _detailUserView.backToUserScreen(id);
    } catch (e) {
      print(e);
    }
  }
}
