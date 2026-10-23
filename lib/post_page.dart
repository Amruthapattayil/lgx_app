
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late Future<List<dynamic>> postsFuture;

  String searchQuery = '';
  Timer? searchTimer;

  
  Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    throw Exception('Failed to load posts');
  }

  @override
  void initState() {
    super.initState();
    postsFuture = fetchPosts();
  }

  void retryFetch() {
    setState(() {
      postsFuture = fetchPosts();
    });
  }

  void searchPosts(String value) {
    searchTimer?.cancel();

    searchTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        if (!mounted) return;

        setState(() {
          searchQuery = value.toLowerCase().trim();
        });
      },
    );
  }
  @override
  void dispose() {
    searchTimer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini API App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: searchPosts,
              decoration: const InputDecoration(
                hintText: 'Search posts by title...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: postsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Could not load posts'),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: retryFetch,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                final posts = snapshot.data ?? [];

                if (posts.isEmpty) {
                  return const Center(
                    child: Text('No posts available'),
                  );
                }

                final filteredPosts = posts.where((post) {
                  final title = post['title']
                      .toString()
                      .toLowerCase();

                  return title.contains(searchQuery);
                }).toList();

                if (filteredPosts.isEmpty) {
                  return const Center(
                    child: Text('No matching posts found'),
                  );
                }
                return ListView.builder(
                  itemCount: filteredPosts.length,
                  itemBuilder: (context, index) {
                    final post = filteredPosts[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text('${post['id']}'),
                        ),
                        title: Text(
                          post['title'] ?? 'No title',
                        ),
                        subtitle: Text(
                          post['body'] ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
