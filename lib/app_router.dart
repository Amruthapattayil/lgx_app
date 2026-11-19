
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'cubit/auth_cubit.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'bloc/posts_bloc_page.dart';
import 'screens/post_detailes.dart';
import 'profile_page.dart';
import 'login.dart';
import 'providers/theme_notifier.dart';
import 'widgets/main_navigation_screen.dart';

GoRouter createAppRouter(AuthCubit authCubit) {
  return GoRouter(
    initialLocation: '/',

    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigationScreen(
            navigationShell: navigationShell,
          );
        },
        branches: [
          
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/posts',
                builder: (context, state) => const PostsBlocPage(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return PostDetailsScreen(postId: id);
                    },
                  ),
                ],
              ),
            ],
          ),

          
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),

  
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),


      GoRoute(
        path: '/login',
        builder: (context, state) {
          final theme = context.watch<ThemeNotifier>();

          return LoginPage(
            isDarkMode: theme.isDarkMode,
            onThemeChanged: (value) async {
              if (theme.isDarkMode != value) {
                theme.toggleTheme();
              }
            },
          );
        },
      ),
    ],

    redirect: (context, state) {
      final isLoggedIn = authCubit.state;

      if (!isLoggedIn &&
          state.matchedLocation == '/profile') {
        return Uri(
          path: '/login',
          queryParameters: {
            'from': state.uri.toString(),
          },
        ).toString();
      }

      return null;
    },
  );
}
