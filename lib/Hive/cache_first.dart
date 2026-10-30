
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class Task2OfflinePage extends StatefulWidget {
  const Task2OfflinePage({super.key});

  @override
  State<Task2OfflinePage> createState() => _Task2OfflinePageState();
}

class _Task2OfflinePageState extends State<Task2OfflinePage> {
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

    final cachedPosts = box.get('posts');

    if (!mounted) return;

    
    if (cachedPosts != null) {
      setState(() {
        posts = List<dynamic>.from(cachedPosts);
        isLoading = false;
        errorMessage = null;
      });
    }

    try {
      
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      if (response.statusCode == 200) {
        
        final latestPosts = jsonDecode(response.body);

        
        await box.put('posts', latestPosts);

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
    
      if (!mounted) return;

      setState(() {
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
        title: const Text('Task 2 - Offline First'),
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
