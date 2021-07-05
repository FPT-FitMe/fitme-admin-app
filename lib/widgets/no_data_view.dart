import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataView extends StatelessWidget {
  final String title;
  const NoDataView({
    Key? key,
    this.title = "Không tìm thấy thông tin",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            title,
            style: TextStyle(
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
