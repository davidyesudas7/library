import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:library_client/library_client.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/pages/user_login_page.dart';
import '../../features/library/presentation/pages/home_page.dart';
import '../../features/auth/presentation/pages/admin_login_page.dart';
import '../../features/admin/presentation/pages/librarian_dashboard_page.dart';
import '../../features/admin/presentation/pages/manage_catalog_page.dart';
import '../../features/admin/presentation/pages/manage_category_page.dart';
import '../../features/admin/presentation/pages/add_new_book_page.dart';
import '../../features/library/presentation/pages/book_detail_page.dart';
import '../network/serverpod_client.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final user = ref.watch(authProvider);
  final isLoggedIn = user != null;
  final isAdmin = isLoggedIn && user.scopeNames.contains('serverpod.admin');

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isGoingToAdmin = state.matchedLocation.startsWith('/admin');

      if (isGoingToAdmin && state.matchedLocation != '/admin/login') {
        if (!isAdmin) {
          return '/admin/login';
        }
      }

      if (state.matchedLocation == '/admin/login' && isAdmin) {
        return '/admin';
      }

      if (state.matchedLocation == '/login' && isLoggedIn) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/book/:id',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          final extra = state.extra;
          final book = extra is Book ? extra : null;
          return BookDetailPage(bookId: id, book: book);
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const UserLoginPage(),
      ),
      GoRoute(
        path: '/admin/login',
        builder: (context, state) => const AdminLoginPage(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const LibrarianDashboardPage(),
      ),
      GoRoute(
        path: '/admin/catalog',
        builder: (context, state) => const ManageCatalogPage(),
      ),
      GoRoute(
        path: '/admin/catalog/new',
        builder: (context, state) => const AddNewBookPage(),
      ),
      GoRoute(
        path: '/admin/catalog/edit',
        builder: (context, state) {
          final extra = state.extra;
          final book = extra is Book ? extra : null;
          return AddNewBookPage(existingBook: book);
        },
      ),
      GoRoute(
        path: '/admin/category/:id',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return ManageCategoryPage(categoryId: id);
        },
      ),
    ],
  );
}
