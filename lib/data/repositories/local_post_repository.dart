import '../../domain/repositories/post_repository.dart';

class LocalPostRepository implements PostRepository {
  final List<dynamic> savedPosts;

  LocalPostRepository(this.savedPosts);

  @override
  Future<List<dynamic>> fetchPosts() async {
    return savedPosts;
  }
}