
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class HivePage extends StatefulWidget {
  const HivePage({super.key});

  @override
  State<HivePage> createState() => _HivePageState();
}

class _HivePageState extends State<HivePage> {
  List<dynamic> posts = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  Future<void> loadPosts() async {
    final box = await Hive.openBox('postsBox');

    try {
      // Step 1: Fetch posts from API
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      if (response.statusCode == 200) {
        // Step 2: Convert JSON into a list
        final latestPosts = jsonDecode(response.body);

        // Step 3: Save posts in Hive
        await box.put('posts', latestPosts);

        // Step 4: Display API posts
        if (!mounted) return;

        setState(() {
          posts = latestPosts;
          isLoading = false;
          errorMessage = null;
        });
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      // Step 5: If API fails, read cached posts
      final cachedPosts = box.get('posts');

      if (!mounted) return;

      setState(() {
        posts = cachedPosts == null
            ? []
            : List<dynamic>.from(cachedPosts);
        isLoading = false;
        errorMessage = posts.isEmpty
            ? 'Unable to load posts. No cached data available.'
            : 'Internet unavailable. Showing cached posts.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 1 - Hive Caching'),
        actions: [
          IconButton(
            onPressed: loadPosts,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(errorMessage!),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];

                      return Card(
                        child: ListTile(
                          title: Text(post['title'].toString()),
                          subtitle: Text(post['body'].toString()),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
