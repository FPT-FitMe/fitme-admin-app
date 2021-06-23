import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/screens/DashboardScreen/dashboard.dart';
import 'package:fitme_admin_app/screens/LoginScreen/login.dart';

getRoutes() {
  return {
    AppRoutes.login: (context) => LoginScreen(),
    AppRoutes.dashboard: (context) => DashboardScreen(),
  };
}
