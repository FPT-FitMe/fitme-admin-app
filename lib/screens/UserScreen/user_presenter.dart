import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/user.dart';
import 'package:fitme_admin_app/repository/user_repository.dart';
import 'package:fitme_admin_app/screens/UserScreen/user_view.dart';

class UserPresenter {
  UserView _userView;
  late UserRepository _userRepository;

  UserPresenter(this._userView) {
    _userRepository = new Injector().userRepository;
  }

  void loadAllUsers() async {
    try {
      List<User> listUsers = await _userRepository.getAllUsers();
      _userView.loadUsers(listUsers);
    } catch (e) {
      print(e);
    }
  }

  void deleteUser(int id) async {
    try {
      await _userRepository.disableUser(id);
      _userView.refresh();
    } catch (e) {
      print(e);
    }
  }
}
