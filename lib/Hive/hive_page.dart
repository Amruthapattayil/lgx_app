
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
  String message = '';

  late Box<dynamic> postsBox;

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  Future<void> loadPosts() async {
    postsBox = await Hive.openBox('postsBox');


    final cachedPosts = postsBox.get('posts', defaultValue: []);

    if (cachedPosts is List && cachedPosts.isNotEmpty) {
      setState(() {
        posts = cachedPosts;
        isLoading = false;
      });
    }

    
    await fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;

        
        await postsBox.put('posts', data);

        
        if (!mounted) return;

        setState(() {
          posts = data;
          isLoading = false;
          message = '';
        });
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      
      if (!mounted) return;

      setState(() {
        isLoading = false;
        message = posts.isEmpty
            ? 'Unable to load posts. Connect to the internet first.'
            : 'Offline: Showing saved posts.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Cached Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchPosts,
            tooltip: 'Refresh posts',
          ),
        ],
      ),
      body: Column(
        children: [
          if (message.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(message),
            ),
          if (isLoading)
            const LinearProgressIndicator(),
          Expanded(
            child: posts.isEmpty && isLoading
                ? const SizedBox.shrink()
                : posts.isEmpty
                    ? const Center(child: Text('No posts available'))
                    : ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = Map<String, dynamic>.from(
                            posts[index] as Map,
                          );

                          return ListTile(
                            leading: CircleAvatar(
                              child: Text('${post['id']}'),
                            ),
                            title: Text(post['title'] ?? ''),
                            subtitle: Text(post['body'] ?? ''),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
