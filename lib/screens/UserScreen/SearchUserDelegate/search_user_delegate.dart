import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/models/user.dart';
import 'package:fitme_admin_app/screens/LoadingScreen/loading.dart';
import 'package:fitme_admin_app/screens/UserScreen/SearchUserDelegate/search_user_presenter.dart';
import 'package:fitme_admin_app/screens/UserScreen/SearchUserDelegate/search_user_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchUserDelegate extends SearchDelegate implements SearchUserView {
  late SearchUserPresenter _presenter;

  SearchUserDelegate() {
    _presenter = new SearchUserPresenter(this);
  }
  @override
  String? get searchFieldLabel => "Bạn đang tìm kiếm gì?";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: _presenter.searchUser(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingScreen();
          } else {
            List<User> listUsers = snapshot.data as List<User>;
            if (listUsers.length == 0) return _buildNotFoundScreen();
            return ListView.builder(
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
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [],
    );
  }

  _buildNotFoundScreen() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          SvgPicture.asset(
            "assets/images/no_data.svg",
            fit: BoxFit.cover,
            height: 250,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Không tìm thấy thông tin",
            style: TextStyle(
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
