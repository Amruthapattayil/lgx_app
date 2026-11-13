
import 'dart:convert';
import 'package:http/http.dart' as http;

class PostsRepository {
  Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> posts = jsonDecode(response.body);
      return posts;
    } else {
      throw Exception(
        'Failed to fetch posts: ${response.statusCode}',
      );
    }
  }
}
