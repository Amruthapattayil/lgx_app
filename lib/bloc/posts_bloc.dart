
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

abstract class PostsEvent {}

class FetchPosts extends PostsEvent {}


abstract class PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<dynamic> posts;

  PostsLoaded(this.posts);
}

class PostsError extends PostsState {
  final String message;

  PostsError(this.message);
}


class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsLoading()) {
    on<FetchPosts>(_onFetchPosts);
  }

  Future<void> _onFetchPosts(
    FetchPosts event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoading());

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> posts =
            jsonDecode(response.body);

        emit(PostsLoaded(posts));
      } else {
        emit(PostsError(
          'Failed to fetch posts: ${response.statusCode}',
        ));
      }
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }
}
