import 'package:get/get.dart';
import 'package:github_flutter_explorer/app/data/model/user_model.dart';
import 'package:github_flutter_explorer/app/data/services/github_service.dart';

class UserController extends GetxController {
  final user = Rxn<UserModel>();
  final loading = true.obs;
  final error = ''.obs;

  final GitHubService _service = GitHubService();

  void fetchUser(String username) async {
    try {
      loading.value = true;
      error.value = '';
      user.value = await _service.fetchUser(username);
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }
}
