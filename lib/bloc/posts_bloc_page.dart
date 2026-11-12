
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'posts_bloc.dart';

class PostsBlocPage extends StatelessWidget {
  const PostsBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts using BLoC'),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {

        
          if (state is PostsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          
          if (state is PostsLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${post['id']}'),
                    ),
                    title: Text(post['title']),
                    subtitle: Text(post['body']),
                  ),
                );
              },
            );
          }

          
          if (state is PostsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
