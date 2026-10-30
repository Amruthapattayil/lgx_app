import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class PostService {
  final Box postsBox = Hive.box('postsBox');


  List<dynamic> getCachedPosts() {
    final cachedPosts = postsBox.get('posts');

    if (cachedPosts == null) {
      return [];
    }

    return List<dynamic>.from(cachedPosts);
  }


  Future<List<dynamic>> fetchAndCachePosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      final latestPosts =
          jsonDecode(response.body) as List<dynamic>;

      await postsBox.put('posts', latestPosts);

      return latestPosts;
    }

    throw Exception('Failed to fetch posts');
  }
}