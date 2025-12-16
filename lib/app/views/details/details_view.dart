import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_flutter_explorer/app/data/model/repository_model.dart';
import 'package:github_flutter_explorer/app/data/model/user_model.dart';
import 'package:github_flutter_explorer/app/routes/app_pages.dart';
import 'package:github_flutter_explorer/app/views/details/user_datils_page.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailsView extends StatelessWidget {
  const DetailsView({super.key});


  @override
  Widget build(BuildContext context) {
    final RepositoryModel repo = Get.arguments;

    final date = DateFormat('MM-dd-yyyy HH:mm').format(repo.updatedAt);

    return Scaffold(
      appBar: AppBar(title: Text(repo.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                  CachedNetworkImageProvider(repo.ownerAvatar),
                ),
                const SizedBox(width: 12),
                Text(repo.ownerName,
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 16),
            Text(repo.description),
            const SizedBox(height: 16),
            Text('⭐ Stars: ${repo.stars}'),
            Text('Last Updated: $date'),
            TextButton(onPressed: (){
              Get.toNamed(Routes.user, arguments: repo.ownerName);
            }, child: Text('More Details'))
          ],
        ),
      ),
    );
  }
}