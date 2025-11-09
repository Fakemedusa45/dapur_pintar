// lib/application/providers/home_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';
import 'package:dapur_pintar/infrastructure/remote/mock_recipe_repository.dart';

/// --- ENUM DEFINITIONS ---
enum DifficultyFilter { mudah, sedang, sulit }
enum CategoryFilter { sarapan, makanSiang, makanMalam, dessert }

/// --- STATE CLASS ---
class HomeState {
  final List<Recipe> allRecipes;
  final List<Recipe> filteredRecipes;
  final String searchQuery;
  final int? maxDuration;
  final DifficultyFilter? difficulty;
  final CategoryFilter? category;
  final String mustIncludeIngredient;
  final String mustNotIncludeIngredient;

  const HomeState({
    required this.allRecipes,
    required this.filteredRecipes,
    this.searchQuery = '',
    this.maxDuration,
    this.difficulty,
    this.category,
    this.mustIncludeIngredient = '',
    this.mustNotIncludeIngredient = '',
  });

  /// CopyWith with optional null-replacement handling
  HomeState copyWith({
    List<Recipe>? allRecipes,
    List<Recipe>? filteredRecipes,
    String? searchQuery,
    int? maxDuration,
    DifficultyFilter? difficulty,
    CategoryFilter? category,
    String? mustIncludeIngredient,
    String? mustNotIncludeIngredient,
  }) {
    return HomeState(
      allRecipes: allRecipes ?? this.allRecipes,
      filteredRecipes: filteredRecipes ?? this.filteredRecipes,
      searchQuery: searchQuery ?? this.searchQuery,
      maxDuration: maxDuration ?? this.maxDuration,
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
      mustIncludeIngredient: mustIncludeIngredient ?? this.mustIncludeIngredient,
      mustNotIncludeIngredient: mustNotIncludeIngredient ?? this.mustNotIncludeIngredient,
    );
  }
}

/// --- NOTIFIER CLASS ---
class HomeNotifier extends StateNotifier<HomeState> {
  final MockRecipeRepository _repository;

  HomeNotifier(this._repository)
      : super(const HomeState(allRecipes: [], filteredRecipes: [])) {
    _loadRecipes();
  }

  void _loadRecipes() {
    final recipes = _repository.getRecipes();
    state = state.copyWith(allRecipes: recipes, filteredRecipes: recipes);
  }

  // === SETTERS ===
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void setMaxDuration(int? duration) {
    state = state.copyWith(maxDuration: duration);
    _applyFilters();
  }

  void setDifficulty(DifficultyFilter? filter) {
    state = state.copyWith(difficulty: filter);
    _applyFilters();
  }

  void setCategory(CategoryFilter? filter) {
    state = state.copyWith(category: filter);
    _applyFilters();
  }

  void setMustIncludeIngredient(String ingredient) {
    state = state.copyWith(mustIncludeIngredient: ingredient);
    _applyFilters();
  }

  void setMustNotIncludeIngredient(String ingredient) {
    state = state.copyWith(mustNotIncludeIngredient: ingredient);
    _applyFilters();
  }

  void resetFilters() {
    state = state.copyWith(
      searchQuery: '',
      maxDuration: null,
      difficulty: null,
      category: null,
      mustIncludeIngredient: '',
      mustNotIncludeIngredient: '',
    );
    _applyFilters();
  }

  // === CRUD ===
  void addRecipe(Recipe recipe) {
    _repository.addRecipe(recipe);
    _loadRecipes();
    _applyFilters();
  }

  void updateRecipe(Recipe recipe) {
    _repository.updateRecipe(recipe);
    _loadRecipes();
    _applyFilters();
  }

  void deleteRecipe(String id) {
    _repository.deleteRecipe(id);
    _loadRecipes();
    _applyFilters();
  }

  // === FILTER LOGIC ===
  void _applyFilters() {
    List<Recipe> results = state.allRecipes;

    // 🔍 Filter by search query
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      results = results
          .where((r) => r.title.toLowerCase().contains(query))
          .toList();
    }

    // ⏱️ Filter by duration
    if (state.maxDuration != null) {
      results = results.where((r) => r.duration <= state.maxDuration!).toList();
    }

    // 🧩 Filter by difficulty
    if (state.difficulty != null) {
      final difficultyString = switch (state.difficulty!) {
        DifficultyFilter.mudah => 'Mudah',
        DifficultyFilter.sedang => 'Sedang',
        DifficultyFilter.sulit => 'Sulit',
      };
      results = results.where((r) => r.difficulty == difficultyString).toList();
    }

    // 🍽️ Filter by category
    if (state.category != null) {
      final categoryString = switch (state.category!) {
        CategoryFilter.sarapan => 'Sarapan',
        CategoryFilter.makanSiang => 'Makan Siang',
        CategoryFilter.makanMalam => 'Makan Malam',
        CategoryFilter.dessert => 'Dessert',
      };
      results = results.where((r) => r.category == categoryString).toList();
    }

    // 🧂 Filter by must-include ingredient
    if (state.mustIncludeIngredient.isNotEmpty) {
      final include = state.mustIncludeIngredient.toLowerCase();
      results = results
          .where((r) => r.ingredients.any(
              (ing) => ing.toLowerCase().contains(include)))
          .toList();
    }

    // 🚫 Filter by must-not-include ingredient
    if (state.mustNotIncludeIngredient.isNotEmpty) {
      final exclude = state.mustNotIncludeIngredient.toLowerCase();
      results = results
          .where((r) => !r.ingredients.any(
              (ing) => ing.toLowerCase().contains(exclude)))
          .toList();
    }

    // ✅ Update state
    state = state.copyWith(filteredRecipes: results);
  }
}

/// --- PROVIDER ---
final homeNotifierProvider =
    StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(MockRecipeRepository());
});
