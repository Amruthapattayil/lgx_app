
import 'package:flutter/material.dart';
import '../post_service.dart';

class PostsNotifier extends ChangeNotifier {


  final PostService postService = PostService();

  
  List<dynamic> _posts = [];

  bool _isLoading = true;
  bool _isRefreshing = false;

  String? _errorMessage;
  String _searchQuery = '';
  int _searchToken = 0;

  List<dynamic> get posts => _posts;

  bool get isLoading => _isLoading;

  bool get isRefreshing => _isRefreshing;

  String? get errorMessage => _errorMessage;

  String get searchQuery => _searchQuery;

  
  Future<void> loadPosts() async {

    final cachedPosts = postService.getCachedPosts();

    _posts = cachedPosts;
    _isLoading = cachedPosts.isEmpty;
    _isRefreshing = true;
    _errorMessage = null;

    notifyListeners();

    try {

      final latestPosts =
          await postService.fetchAndCachePosts();

      _posts = latestPosts;
      _isLoading = false;
      _isRefreshing = false;
      _errorMessage = null;

      notifyListeners();

    } catch (e) {

      _isLoading = false;
      _isRefreshing = false;

      _errorMessage = _posts.isEmpty
          ? 'Unable to load posts. No cached data available.'
          : 'Internet unavailable. Showing cached posts.';

      notifyListeners();
    }
  }

  
  void searchPosts(String value) {

    final currentToken = ++_searchToken;

    Future.delayed(const Duration(milliseconds: 500), () {

      if (currentToken != _searchToken) {
        return;
      }

      _searchQuery = value.toLowerCase().trim();

      notifyListeners();
    });
  }


  List<dynamic> get filteredPosts {

    return _posts.where((post) {

      final title = post['title']
          .toString()
          .toLowerCase();

      return title.contains(_searchQuery);

    }).toList();
  }
}
