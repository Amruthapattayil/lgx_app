
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:lgx_app/bloc/posts_bloc.dart';
import 'package:lgx_app/repository/posts_repository.dart';

import 'posts_bloc_test.mocks.dart';

@GenerateMocks([PostsRepository])
void main() {
  late MockPostsRepository mockRepository;

  setUp(() {
    mockRepository = MockPostsRepository();
  });

  final fakePosts = [
    {'id': 1, 'title': 'Flutter'},
    {'id': 2, 'title': 'Dart'},
  ];

  blocTest<PostsBloc, PostsState>(
    'emits PostsLoading and PostsLoaded',
    build: () {
      when(mockRepository.fetchPosts())
          .thenAnswer((_) async => fakePosts);

      return PostsBloc(mockRepository);
    },
    act: (bloc) => bloc.add(FetchPosts()),
    expect: () => [
      isA<PostsLoading>(),
      isA<PostsLoaded>(),
    ],
    verify: (_) {
  verify(mockRepository.fetchPosts()).called(1);
debugPrint('PostsLoading emitted');
debugPrint('PostsLoaded emitted');
},
  );
}
