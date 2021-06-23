import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/constants/dashboard_items.dart';
import 'package:fitme_admin_app/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FitMe Dashboard",
          style: TextStyle(
            color: AppColors.primary,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuButton<String>(
            offset: Offset(-20, 50),
            itemBuilder: (BuildContext context) {
              return ['Logout']
                  .map((String choice) => PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      ))
                  .toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            listDashboardItems.length,
            (index) => DashboardCard(item: listDashboardItems[index]),
          ),
        ),
      ),
    );
  }
}
