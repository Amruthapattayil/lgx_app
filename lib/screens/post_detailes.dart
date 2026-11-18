
import 'package:flutter/material.dart';

class PostDetailsScreen extends StatelessWidget {
  final String postId;

  const PostDetailsScreen({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: Center(
        child: Text(
          'Selected Post ID: $postId',
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
