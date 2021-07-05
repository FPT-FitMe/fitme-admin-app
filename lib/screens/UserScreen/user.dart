import 'package:fitme_admin_app/models/user.dart';
import 'package:fitme_admin_app/screens/LoadingScreen/loading.dart';
import 'package:fitme_admin_app/screens/UserScreen/SearchUserDelegate/search_user_delegate.dart';
import 'package:fitme_admin_app/screens/UserScreen/user_presenter.dart';
import 'package:fitme_admin_app/screens/UserScreen/user_view.dart';
import 'package:fitme_admin_app/widgets/user_list_tile.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> implements UserView {
  late UserPresenter _presenter;
  bool _isLoading = true;
  List<User> listUsers = [];

  _UserScreenState() {
    _presenter = new UserPresenter(this);
    _presenter.loadAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Người dùng"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchUserDelegate(listUsers: listUsers),
              );
            },
          ),
        ],
      ),
      body: _isLoading == true
          ? LoadingScreen()
          : ListView.builder(
              itemCount: listUsers.length,
              itemBuilder: (context, index) => UserListTile(
                isSearching: false,
                user: listUsers[index],
              ),
            ),
    );
  }

  @override
  void loadUsers(List<User> users) {
    setState(() {
      _isLoading = false;
      listUsers = users;
    });
  }
}
