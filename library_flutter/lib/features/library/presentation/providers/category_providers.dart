import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:library_client/library_client.dart';
import '../../data/repositories/category_repository_impl.dart';

part 'category_providers.g.dart';

@riverpod
Future<List<Category>> categories(Ref ref) async {
  final repository = ref.watch(categoryRepositoryProvider);
  final result = await repository.getAllCategories();
  return result.fold(
    (failure) => throw Exception(failure),
    (categories) => categories,
  );
}

@riverpod
class CategoryNotifier extends _$CategoryNotifier {
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
