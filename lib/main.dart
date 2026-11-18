
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'providers/cart_notifier.dart';
import 'providers/auth_notifier.dart';
import 'providers/theme_notifier.dart';

import 'repository/posts_repository.dart';
import 'bloc/posts_bloc.dart';
import 'cubit/auth_cubit.dart';
import 'app_router.dart';

void main() {
  final authCubit = AuthCubit();
  final router = createAppRouter(authCubit);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: authCubit,
          ),
          BlocProvider(
            create: (_) =>
                PostsBloc(PostsRepository())..add(FetchPosts()),
          ),
        ],
        child: MyApp(router: router),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({
    super.key,
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeNotifier>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: theme.themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routerConfig: router,
    );
  }
}
