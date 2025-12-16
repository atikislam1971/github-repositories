import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_flutter_explorer/app/controllers/home_controller.dart';
import 'package:github_flutter_explorer/app/routes/app_pages.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final searchController = TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Repositories'),
        actions: [
          PopupMenuButton<SortType>(
            icon: const Icon(Icons.sort),
              onSelected: (value){
              controller.sortType.value=value;
              controller.sort();
              },
              itemBuilder: (context) => [
                //sorting Date-Time
                const PopupMenuItem(
                  value: SortType.updated,
                    child: Text('Date-Time')
                ),
                //sorting Star Count
                const PopupMenuItem(
                  value: SortType.stars,
                    child: Text('Star Count')
                )
          ])
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),

            //When need another github repositories then search another repositories but by default search 'flutter' repositories
            child: TextField(
              controller: searchController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search repositories…',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  controller.search(value.trim());
                }
              },
            ),
          ),
        ),
      ),
      body: Obx(() {

        //error handling with when no internet connection showing snackbar
        if(controller.errorMessage.isNotEmpty){
          WidgetsBinding.instance.addPostFrameCallback((_){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(controller.errorMessage.value, style: TextStyle(color: Colors.red),),
                  behavior: SnackBarBehavior.floating,
                  duration : Duration(seconds: 10),
                  backgroundColor: Colors.black,
                )
            );
          });
        }
        return RefreshIndicator(
            onRefresh: () async{
              controller.loadData();
            },
          child: controller.loading.value? Center(child: CircularProgressIndicator())
              : ListView.separated(
            padding: EdgeInsets.all(12),
            itemCount: controller.repos.length,
            separatorBuilder: (_,__) => const SizedBox(height: 8,),
            itemBuilder: (_, i) {
              final repo = controller.repos[i];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${i+1}'),
                  ),
                  title: Text(repo.name, style: TextStyle(color: Colors.amber,fontSize: 18, fontWeight: FontWeight.bold),),
                  subtitle: Text('${repo.ownerName} • ⭐ ${repo.stars}'),
                  onTap: () => Get.toNamed(Routes.details, arguments: repo),
                ),
              );
            },
          )
        );
      }),
    );
  }
}