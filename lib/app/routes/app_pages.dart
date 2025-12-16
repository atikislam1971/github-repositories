import 'package:get/get.dart';
import 'package:github_flutter_explorer/app/views/details/user_datils_page.dart';
import 'package:github_flutter_explorer/app/views/home_view.dart';
import '../views/details/details_view.dart';


part 'app_routes.dart';


class AppPages {
  static const initial = Routes.home;


  static final routes = [
    GetPage(name: Routes.home, page: () => const HomeView()),
    GetPage(name: Routes.details, page: () => const DetailsView()),
    GetPage(name: Routes.user, page: () => const UserDetailsView()),
  ];
}
