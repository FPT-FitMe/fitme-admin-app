import 'package:community_material_icon/community_material_icon.dart';
import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/models/dashboard_item.dart';

final List<DashboardItem> listDashboardItems = [
  DashboardItem(
    title: "Người dùng",
    iconData: CommunityMaterialIcons.account,
    route: AppRoutes.users,
  ),
  DashboardItem(
    title: "Huấn luyện viên",
    iconData: CommunityMaterialIcons.account_heart,
    route: AppRoutes.coaches,
  ),
  DashboardItem(
    title: "Bài tập",
    iconData: CommunityMaterialIcons.arm_flex,
    route: AppRoutes.workouts,
  ),
  DashboardItem(
    title: "Khóa tập",
    iconData: CommunityMaterialIcons.clipboard_list,
    route: AppRoutes.courses,
  ),
  DashboardItem(
    title: "Món ăn",
    iconData: CommunityMaterialIcons.pot_steam,
    route: AppRoutes.meals,
  ),
  DashboardItem(
    title: "Bài viết",
    iconData: CommunityMaterialIcons.pencil,
    route: AppRoutes.posts,
  ),
  DashboardItem(
    title: "Tags",
    iconData: CommunityMaterialIcons.tag,
    route: AppRoutes.tags,
  ),
  DashboardItem(
    title: "Thành tích",
    iconData: CommunityMaterialIcons.medal,
    route: AppRoutes.achievements,
  ),
];
