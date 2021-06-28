import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/models/user.dart';
import 'package:fitme_admin_app/screens/LoadingScreen/loading.dart';
import 'package:fitme_admin_app/screens/UserScreen/user_presenter.dart';
import 'package:fitme_admin_app/screens/UserScreen/user_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
  }

  @override
  void initState() {
    super.initState();
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
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.primary,
      ),
      body: _isLoading == true
          ? LoadingScreen()
          : ListView.builder(
              itemCount: listUsers.length,
              itemBuilder: (context, index) => Slidable(
                actionPane: SlidableDrawerActionPane(),
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        listUsers[index].imageUrl != null
                            ? listUsers[index].imageUrl.toString()
                            : 'https://images.unsplash.com/photo-1569913486515-b74bf7751574?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=635&q=80',
                      ),
                    ),
                    title: Text(listUsers[index].username),
                    subtitle: Text(
                        '${listUsers[index].email} - ${listUsers[index].phone}'),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.detailUser,
                          arguments: listUsers[index]);
                    },
                  ),
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: AppColors.red500,
                    icon: Icons.delete,
                  ),
                ],
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
