import 'package:get/get.dart';
import 'package:github_flutter_explorer/app/data/model/repository_model.dart';
import 'package:hive/hive.dart';
import '../data/services/github_service.dart';


enum SortType { stars, updated }


class HomeController extends GetxController {
  final repos = <RepositoryModel>[].obs;
  final loading = false.obs;
  final sortType = SortType.stars.obs;
  final errorMessage=''.obs;


  final _service = GitHubService();
  final _repoBox = Hive.box('repoBox');
  final _settingsBox = Hive.box('settingsBox');


  @override
  void onInit() {
    super.onInit();
    loadSortType();
    loadData();
  }


  void loadSortType() {
    final saved = _settingsBox.get('sort');
    if (saved != null) sortType.value = SortType.values[saved];
  }


  void loadData() async {
    loading.value = true;
    errorMessage.value='';
    try {
      final data = await _service.fetchRepositories();
      repos.assignAll(data);
      _repoBox.put('repos', data.map((e) => e.toJson()).toList());
      sort();
    } catch (e) {
      //error handling
      errorMessage.value=e.toString();

      //fallback to catch
      final cached = _repoBox.get('repos');
      if (cached != null) {
        repos.assignAll((cached as List)
            .map((e) => RepositoryModel.fromJson(e))
            .toList());
      }
    }
    loading.value = false;
  }


  void toggleSort() {
    sortType.value = sortType.value == SortType.stars
        ? SortType.updated
        : SortType.stars;
    _settingsBox.put('sort', sortType.value.index);
    sort();
  }


  void sort() {
    if (sortType.value == SortType.stars) {
      repos.sort((a, b) => b.stars.compareTo(a.stars));
    } else {
      repos.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    }
  }

  Future<void> search(String query) async {
    loading.value = true;
    errorMessage.value='';
    try {
      final data = await _service.fetchRepositories(query: query);
      repos.assignAll(data);
      _repoBox.put('repos', data.map((e) => e.toJson()).toList());
      sort();
    } catch (e) {
      errorMessage.value=e.toString();
      // fallback to cached data (optional)
    }
    loading.value = false;
  }


}