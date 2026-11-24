
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:lgx_app/main.dart';
import 'package:lgx_app/app_router.dart';
import 'package:lgx_app/cubit/auth_cubit.dart';
import 'package:lgx_app/providers/cart_notifier.dart';
import 'package:lgx_app/providers/auth_notifier.dart';
import 'package:lgx_app/providers/theme_notifier.dart';
import 'package:lgx_app/bloc/posts_bloc.dart';
import 'package:lgx_app/data/repositories/remote_post_repository.dart';

void main() {
  testWidgets('App displays Home Screen', (tester) async {
    final authCubit = AuthCubit();
    final router = createAppRouter(authCubit);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartNotifier()),
          ChangeNotifierProvider(create: (_) => AuthNotifier()),
          ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: authCubit),
            BlocProvider(
              create: (_) =>
                  PostsBloc(RemotePostRepository())..add(FetchPosts()),
            ),
          ],
          child: MyApp(router: router),
        ),
      ),
    );

    expect(find.text('Home Screen'), findsOneWidget);
    expect(find.text('Add Item'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());

    router.dispose();
    await authCubit.close();
  });
}
