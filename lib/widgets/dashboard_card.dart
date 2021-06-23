import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/models/dashboard_item.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final DashboardItem item;
  const DashboardCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          splashColor: AppColors.primary,
          onTap: () {},
          child: SizedBox(
            width: 250,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.iconData,
                  size: 48,
                  color: AppColors.primary,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(item.title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
