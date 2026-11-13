
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/posts_repository.dart';
import 'posts_bloc.dart';
import 'posts_bloc_page.dart';

void main() {
  runApp(
    BlocProvider(
  create: (context) =>
      PostsBloc(PostsRepository())..add(FetchPosts()),
  child: const MyApp(),
)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Posts BLoC App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostsBlocPage(),
    );
  }
}
