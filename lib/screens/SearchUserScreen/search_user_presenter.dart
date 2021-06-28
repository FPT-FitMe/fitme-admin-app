import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/user.dart';
import 'package:fitme_admin_app/repository/user_repository.dart';
import 'package:fitme_admin_app/screens/SearchUserScreen/search_user_view.dart';

class SearchUserPresenter {
  SearchUserView _searchUserView;
  late UserRepository _userRepository;

  SearchUserPresenter(this._searchUserView) {
    _userRepository = new Injector().userRepository;
  }

  Future<List<User>> searchUser(String searchTerm) async {
    return await _userRepository.getAllUsers();
  }
}
