import 'package:go_router/go_router.dart';
import 'package:task/features/auth/presentations/page/login_page.dart';
import 'package:task/features/auth/presentations/page/register_page.dart';
import 'package:task/features/auth/presentations/page/splash_screen.dart';
import 'package:task/features/home/presentation/pages/detail_page.dart';
import 'package:task/features/home/presentation/pages/for_category_page.dart';
import 'package:task/features/home/presentation/pages/home_page.dart';
import 'package:task/features/home/presentation/pages/search_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'details',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>?;
            return DetailPage(
              product: data?['product'],
              imageUrl: data?['imageUrl'],
            );
          },
        ),
        GoRoute(path: 'search', builder: (context, state) => SearchPage()),
        GoRoute(
          path: 'category-products',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>?;
            return CategoryProductsPage(
              categoryId: data?['categoryId'],
              categoryName: data?['categoryName'],
            );
          },
        ),
      ],
    ),
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
  ],
);
