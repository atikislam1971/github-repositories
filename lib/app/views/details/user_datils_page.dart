import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_flutter_explorer/app/controllers/user_controller.dart';
import 'package:github_flutter_explorer/app/data/model/user_model.dart';
import 'package:intl/intl.dart';

class UserDetailsView extends StatelessWidget {
  const UserDetailsView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final String username=Get.arguments;
    final controller=Get.put(UserController());

    if(controller.user.value ==null && !controller.loading.value){
      controller.fetchUser(username);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('User Profile'),),
      body: Obx(() {
        if(controller.loading.value){
          return const Center(child: CircularProgressIndicator(),);
        }
        if(controller.error.isNotEmpty){
          return Center(child: Text(controller.error.value),);
        }
        final UserModel user=controller.user.value!;
        String formatedDate(String date) {
          return DateFormat('MM-DD-YYYY').format(DateTime.parse(date));

        }
         return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name ?? 'No Name', style: Theme.of(context).textTheme.headlineLarge,),
              const SizedBox(height: 6,),
              if(user.bio !=null && user.bio!.isNotEmpty)
                Text(user.bio!, style: Theme.of(context).textTheme.bodyMedium,),
              const SizedBox(height: 20,),
              _scetionTitle('Professional Info'),
              _infoRow('Company', user.company),
              _infoRow('Location', user.location),
              _infoRow('Blog', user.blog),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _startCard('Repos', user.publicRepos),
                  _startCard('Gists', user.publicGists),
                  _startCard('Followers', user.followers),
                  _startCard('Follwing', user.following)
                ],
              ),
              const SizedBox(height: 20,),

              _scetionTitle('Account Info'),
              _infoRow('Joined Github', formatedDate(user.createdAt?? '-')),
              _infoRow('Joined Github', formatedDate(user.updatedAt?? '-')),
            ],
          ),
        );
      })

    );
  }

  Widget _scetionTitle(String title){
    return Padding(padding: EdgeInsets.only(bottom: 8),
      child: Text(title,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
    );
  }

  Widget _infoRow(String label, String? value){
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 140, child: Text(label),),
          Expanded(child: Text(value?.isNotEmpty ==true? value!: '-'))
        ],
      ),

    );
  }

  Widget _startCard(String label, int? value){
    return Column(
      children: [
        Text(
          value?.toString() ?? '0',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4,),
        Text(label),
      ],
    );
  }
}
