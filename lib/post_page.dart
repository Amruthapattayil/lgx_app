
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/posts_notifier.dart';

class PostsPage extends StatelessWidget {
  final bool isDarkMode;
  final Future<void> Function(bool) onThemeChanged;

  const PostsPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PostsNotifier>(
      builder: (context, notifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Mini API App'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: notifier.isRefreshing
                    ? null
                    : notifier.loadPosts,
                icon: const Icon(Icons.refresh),
              ),

              Switch(
                value: isDarkMode,
                onChanged: onThemeChanged,
              ),
            ],
          ),

          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  onChanged: notifier.searchPosts,
                  decoration: const InputDecoration(
                    hintText: 'Search posts by title...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              if (notifier.isRefreshing)
                const LinearProgressIndicator(),

              if (notifier.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    notifier.errorMessage!,
                    textAlign: TextAlign.center,
                  ),
                ),

              Expanded(
                child: notifier.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : notifier.posts.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('No posts available'),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: notifier.loadPosts,
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          )
                        : notifier.filteredPosts.isEmpty
                            ? const Center(
                                child: Text(
                                  'No matching posts found',
                                ),
                              )
                            : ListView.builder(
                                itemCount:
                                    notifier.filteredPosts.length,
                                itemBuilder: (context, index) {
                                  final post =
                                      notifier.filteredPosts[index];

                                  return Card(
                                    margin:
                                        const EdgeInsets.symmetric(
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
      },
    );
  }
}
