import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:library_client/library_client.dart';
import '../../features/auth/presentation/pages/user_login_page.dart';
import '../../features/library/presentation/pages/home_page.dart';
import '../../features/auth/presentation/pages/admin_login_page.dart';
import '../../features/admin/presentation/pages/librarian_dashboard_page.dart';
import '../../features/admin/presentation/pages/manage_catalog_page.dart';
import '../../features/admin/presentation/pages/manage_category_page.dart';
import '../../features/admin/presentation/pages/add_new_book_page.dart';
import '../../features/library/presentation/pages/book_detail_page.dart';
import '../network/serverpod_client.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isGoingToAdmin = state.matchedLocation.startsWith('/admin');
      final isLoggedIn = sessionManager.isSignedIn;
      final isAdmin = isLoggedIn && sessionManager.signedInUser?.email == 'admin@library.com';
      
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
          final book = state.extra as Book?;
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
          final book = state.extra as Book?;
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
});
