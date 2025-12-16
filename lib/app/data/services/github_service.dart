import 'package:dio/dio.dart';
import 'package:github_flutter_explorer/app/data/model/repository_model.dart';
import 'package:github_flutter_explorer/app/data/model/user_model.dart';

class GitHubService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<RepositoryModel>> fetchRepositories({
    String query = 'Flutter',
  }) async {
    try {
      final response = await _dio.get(
        'https://api.github.com/search/repositories',
        queryParameters: {
          'q': query,
          'sort': 'stars',
          'order': 'desc',
          'per_page': 50,
          'url':''
        },
      );

      final items = response.data['items'] as List;
      return items.map((e) => RepositoryModel.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw 'No internet connection';
      } else if (e.response?.statusCode == 403) {
        throw 'GitHub API rate limit exceeded';
      } else {
        throw 'Failed to fetch repositories';
      }
    } catch (_) {
      throw 'Something went wrong';
    }
  }
  Future<UserModel> fetchUser( String username) async {
    try{
      final response = await _dio.get('https://api.github.com/users/$username');
      return UserModel.fromJson(response.data);
    }on DioException catch(e){
      if(e.type ==DioExceptionType.connectionError){
        throw 'No Internet Connection';
      }else{
        throw 'failed to fetch user';
      }

    }
  }

}
