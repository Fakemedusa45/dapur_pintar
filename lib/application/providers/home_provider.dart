import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dapur_pintar/application/notifiers/home_notifier.dart';
import 'package:dapur_pintar/infrastructure/remote/mock_recipe_repository.dart';

final mockRecipeRepositoryProvider = Provider((ref) => MockRecipeRepository());

final homeNotifierProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final repository = ref.watch(mockRecipeRepositoryProvider);
  return HomeNotifier(repository);
});