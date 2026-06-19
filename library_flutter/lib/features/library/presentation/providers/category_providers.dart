import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_client/library_client.dart';
import '../../data/repositories/category_repository_impl.dart';

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final repository = ref.watch(categoryRepositoryProvider);
  final result = await repository.getAllCategories();
  return result.fold(
    (failure) => throw Exception(failure),
    (categories) => categories,
  );
});

final categoryNotifierProvider = AsyncNotifierProvider<CategoryNotifier, void>(CategoryNotifier.new);

class CategoryNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> createCategory(Category category) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(categoryRepositoryProvider);
      final result = await repository.createCategory(category);
      return result.fold(
        (failure) => throw Exception(failure),
        (_) {
          ref.invalidate(categoriesProvider);
          return;
        },
      );
    });
  }

  Future<void> updateCategory(Category category) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(categoryRepositoryProvider);
      final result = await repository.updateCategory(category);
      return result.fold(
        (failure) => throw Exception(failure),
        (_) {
          ref.invalidate(categoriesProvider);
          return;
        },
      );
    });
  }

  Future<void> deleteCategory(Category category) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(categoryRepositoryProvider);
      final result = await repository.deleteCategory(category);
      return result.fold(
        (failure) => throw Exception(failure),
        (_) {
          ref.invalidate(categoriesProvider);
          return;
        },
      );
    });
  }
}
