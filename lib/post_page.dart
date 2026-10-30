
import 'package:flutter/material.dart';
import 'post_service.dart';
import 'main.dart';

class PostsPage extends StatefulWidget {
  final bool isDarkMode;
  final Future<void> Function(bool) onThemeChanged;

  const PostsPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostService postService = PostService();

  List<dynamic> posts = [];

  bool isLoading = true;
  bool isRefreshing = false;

  String? errorMessage;
  String searchQuery = '';
  int searchToken = 0;

  @override
  void initState() {
    super.initState();
    loadPosts();
  }


  Future<void> loadPosts() async {

    
    final cachedPosts = postService.getCachedPosts();

    if (!mounted) return;

    setState(() {
      posts = cachedPosts;
      isLoading = cachedPosts.isEmpty;
      isRefreshing = true;
      errorMessage = null;
    });

    try {
  
      final latestPosts =
          await postService.fetchAndCachePosts();

      if (!mounted) return;

      setState(() {
        posts = latestPosts;
        isLoading = false;
        isRefreshing = false;
        errorMessage = null;
      });

    } catch (e) {
  
      if (!mounted) return;

      setState(() {
        isLoading = false;
        isRefreshing = false;

        errorMessage = posts.isEmpty
            ? 'Unable to load posts. No cached data available.'
            : 'Internet unavailable. Showing cached posts.';
      });
    }
  }

  void searchPosts(String value) {
    final currentToken = ++searchToken;

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted || currentToken != searchToken) {
        return;
      }

      setState(() {
        searchQuery = value.toLowerCase().trim();
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final filteredPosts = posts.where((post) {
      final title = post['title']
          .toString()
          .toLowerCase();

      return title.contains(searchQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini API App'),
        centerTitle: true,
        actions: [
  IconButton(
    onPressed: isRefreshing ? null : loadPosts,
    icon: const Icon(Icons.refresh),
  ),

  ValueListenableBuilder<bool>(
    valueListenable: isDarkModeNotifier,
    builder: (context, isDarkMode, child) {
      return Switch(
        value: isDarkMode,
        onChanged: widget.onThemeChanged,
      );
    },
  ),
],
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

      
          if (isRefreshing)
            const LinearProgressIndicator(),

  
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                errorMessage!,
                textAlign: TextAlign.center,
              ),
            ),

      
          Expanded(
            child: isLoading
            ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : posts.isEmpty
                    ? Center(
                   child: Column(
                    mainAxisSize: MainAxisSize.min,
                        children: [
                            const Text('No posts available'),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: loadPosts,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : filteredPosts.isEmpty
                        ? const Center(
                            child: Text('No matching posts found'),
                          )
                        : ListView.builder(
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
                                    child: Text(
                                      '${post['id']}',
                                    ),
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
                          ),
          ),
        ],
      ),
    );
  }
}
