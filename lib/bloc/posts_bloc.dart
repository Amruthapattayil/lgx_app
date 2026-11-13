
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/posts_repository.dart';

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
  final PostsRepository repository;

  PostsBloc(this.repository) : super(PostsLoading()) {
    on<FetchPosts>(_onFetchPosts);
  }

  Future<void> _onFetchPosts(
    FetchPosts event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoading());

    try {
      final posts = await repository.fetchPosts();

      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }
}
