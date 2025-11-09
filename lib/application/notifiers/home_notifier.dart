import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';
import 'package:dapur_pintar/infrastructure/remote/mock_recipe_repository.dart';

// --- Enum Definisi Tetap Sama ---
enum DifficultyFilter { mudah, sedang, sulit }
enum CategoryFilter { sarapan, makanSiang, makanMalam, dessert }

// --- Definisi Kelas HomeState DIPERBAIKI ---
class HomeState {
  final List<Recipe> allRecipes;
  final List<Recipe> filteredRecipes;
  final String searchQuery;
  final int? maxDuration;
  final DifficultyFilter? difficulty;
  final CategoryFilter? category;
  final String mustIncludeIngredient;
  final String mustNotIncludeIngredient;

  // Constructor
  HomeState({
    required this.allRecipes,
    required this.filteredRecipes,
    this.searchQuery = '',
    this.maxDuration,
    this.difficulty,
    this.category,
    this.mustIncludeIngredient = '',
    this.mustNotIncludeIngredient = '',
  });

  // Metode copyWith DITAMBAHKAN
  HomeState copyWith({
    List<Recipe>? allRecipes,
    List<Recipe>? filteredRecipes,
    String? searchQuery,
<<<<<<< HEAD
    int? maxDuration,
    DifficultyFilter? difficulty,
    CategoryFilter? category,
=======
    Object? maxDuration = _undefined,
    Object? difficulty = _undefined,
    Object? category = _undefined,
>>>>>>> e966c1c (UI DONE KAYANYA)
    String? mustIncludeIngredient,
    String? mustNotIncludeIngredient,
  }) {
    return HomeState(
      allRecipes: allRecipes ?? this.allRecipes,
      filteredRecipes: filteredRecipes ?? this.filteredRecipes,
      searchQuery: searchQuery ?? this.searchQuery,
<<<<<<< HEAD
      maxDuration: maxDuration ?? this.maxDuration,
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
=======
      maxDuration: maxDuration == _undefined ? this.maxDuration : (maxDuration as int?),
      difficulty: difficulty == _undefined ? this.difficulty : (difficulty as DifficultyFilter?),
      category: category == _undefined ? this.category : (category as CategoryFilter?),
>>>>>>> e966c1c (UI DONE KAYANYA)
      mustIncludeIngredient: mustIncludeIngredient ?? this.mustIncludeIngredient,
      mustNotIncludeIngredient: mustNotIncludeIngredient ?? this.mustNotIncludeIngredient,
    );
  }
<<<<<<< HEAD
=======
  
  static const _undefined = Object();
>>>>>>> e966c1c (UI DONE KAYANYA)
}
// --- Akhir Definisi Kelas HomeState ---

// --- Kelas HomeNotifier Tetap Sama ---
class HomeNotifier extends StateNotifier<HomeState> {
  final MockRecipeRepository _repository;

  HomeNotifier(this._repository) : super(HomeState(allRecipes: [], filteredRecipes: [])) {
    _loadRecipes();
  }

  void _loadRecipes() {
    final recipes = _repository.getRecipes();
    state = state.copyWith(allRecipes: recipes, filteredRecipes: recipes);
  }

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

  void addRecipe(Recipe recipe) {
    _repository.addRecipe(recipe);
    _loadRecipes(); // Muat ulang daftar resep
    _applyFilters(); // Terapkan filter yang mungkin sedang aktif
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

  void _applyFilters() {
    List<Recipe> results = state.allRecipes;

    if (state.searchQuery.isNotEmpty) {
      results = results.where((r) => r.title.toLowerCase().contains(state.searchQuery.toLowerCase())).toList();
    }

    if (state.maxDuration != null) {
      results = results.where((r) => r.duration <= state.maxDuration!).toList();
    }

    if (state.difficulty != null) {
      String difficultyString = '';
      switch (state.difficulty) {
        case DifficultyFilter.mudah: difficultyString = 'Mudah'; break;
        case DifficultyFilter.sedang: difficultyString = 'Sedang'; break;
        case DifficultyFilter.sulit: difficultyString = 'Sulit'; break;
        default: break;
      }
      results = results.where((r) => r.difficulty == difficultyString).toList();
    }

    if (state.category != null) {
      String categoryString = '';
      switch (state.category) {
        case CategoryFilter.sarapan: categoryString = 'Sarapan'; break;
        case CategoryFilter.makanSiang: categoryString = 'Makan Siang'; break;
        case CategoryFilter.makanMalam: categoryString = 'Makan Malam'; break;
        case CategoryFilter.dessert: categoryString = 'Dessert'; break;
        default: break;
      }
      results = results.where((r) => r.category == categoryString).toList();
    }

    if (state.mustIncludeIngredient.isNotEmpty) {
      final lowerIngredient = state.mustIncludeIngredient.toLowerCase();
      results = results.where((r) => r.ingredients.any((ing) => ing.toLowerCase().contains(lowerIngredient))).toList();
    }

    if (state.mustNotIncludeIngredient.isNotEmpty) {
      final lowerIngredient = state.mustNotIncludeIngredient.toLowerCase();
      results = results.where((r) => !r.ingredients.any((ing) => ing.toLowerCase().contains(lowerIngredient))).toList();
    }

    state = state.copyWith(filteredRecipes: results);
  }
}
// --- Akhir Kelas HomeNotifier ---