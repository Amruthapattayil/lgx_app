import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/repositories/post_repository.dart';

class RemotePostRepository implements PostRepository {
  @override
  Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Failed to fetch posts: ${response.statusCode}',
      );
    }
  }
}