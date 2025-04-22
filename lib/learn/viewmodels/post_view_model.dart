import '../models/post_model.dart';
import '../services/api_services.dart';

class PostViewModel {
  final ApiService apiService;

  PostViewModel({required this.apiService});

  Future<List<Post>> getPosts() async {
    return await apiService.fetchPosts();
  }
}
