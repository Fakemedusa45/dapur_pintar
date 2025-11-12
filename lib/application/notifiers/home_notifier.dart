// lib/application/providers/home_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';
// HAPUS IMPORT MOCK REPO
// import 'package:dapur_pintar/infrastructure/remote/mock_recipe_repository.dart';
// TAMBAHKAN IMPORT FIREBASE
import 'package:cloud_firestore/cloud_firestore.dart';

/// --- ENUM DEFINITIONS (Tetap Sama) ---
enum DifficultyFilter { mudah, sedang, sulit }
enum CategoryFilter { sarapan, makanSiang, makanMalam, dessert }

/// --- STATE CLASS (Modifikasi) ---
class HomeState {
  // HAPUS KEDUA LIST INI. Data akan datang dari StreamBuilder di UI.
  // final List<Recipe> allRecipes;
  // final List<Recipe> filteredRecipes;

  final String searchQuery;
  final int? maxDuration;
  final DifficultyFilter? difficulty;
  final CategoryFilter? category;
  final String mustIncludeIngredient;
  final String mustNotIncludeIngredient;

  const HomeState({
    // HAPUS KEDUA LIST INI
    // required this.allRecipes,
    // required this.filteredRecipes,
    this.searchQuery = '',
    this.maxDuration,
    this.difficulty,
    this.category,
    this.mustIncludeIngredient = '',
    this.mustNotIncludeIngredient = '',
  });

  /// CopyWith with optional null-replacement handling
  HomeState copyWith({
    // HAPUS KEDUA LIST INI
    // List<Recipe>? allRecipes,
    // List<Recipe>? filteredRecipes,
    String? searchQuery,
    int? maxDuration,
    DifficultyFilter? difficulty,
    CategoryFilter? category,
    String? mustIncludeIngredient,
    String? mustNotIncludeIngredient,
  }) {
    return HomeState(
      // HAPUS KEDUA LIST INI
      // allRecipes: allRecipes ?? this.allRecipes,
      // filteredRecipes: filteredRecipes ?? this.filteredRecipes,
      searchQuery: searchQuery ?? this.searchQuery,
      maxDuration: maxDuration ?? this.maxDuration,
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
      mustIncludeIngredient: mustIncludeIngredient ?? this.mustIncludeIngredient,
      mustNotIncludeIngredient: mustNotIncludeIngredient ?? this.mustNotIncludeIngredient,
    );
  }
}

/// --- NOTIFIER CLASS (Modifikasi) ---
class HomeNotifier extends StateNotifier<HomeState> {
  // HAPUS REPOSITORY
  // final MockRecipeRepository _repository;

  // TAMBAHKAN REFERENSI COLLECTION FIREBASE
  final CollectionReference _recipesCollection =
      FirebaseFirestore.instance.collection('recipes');

  HomeNotifier()
      // HAPUS INISIASI LIST KOSONG
      : super(const HomeState()) {
    // HAPUS _loadRecipes();
  }

  // HAPUS _loadRecipes()
  // void _loadRecipes() { ... }

  // === SETTERS (Modifikasi) ===
  // Semua setter ini sekarang hanya perlu update state
  // Hapus panggilan _applyFilters() dari semua setter
  // Kita akan panggil _applyFilters() secara manual jika perlu
  
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    // Hapus _applyFilters();
  }

  void setMaxDuration(int? duration) {
    state = state.copyWith(maxDuration: duration);
    // Hapus _applyFilters();
  }

  void setDifficulty(DifficultyFilter? filter) {
    state = state.copyWith(difficulty: filter);
    // Hapus _applyFilters();
  }

  void setCategory(CategoryFilter? filter) {
    state = state.copyWith(category: filter);
    // Hapus _applyFilters();
  }

  void setMustIncludeIngredient(String ingredient) {
    state = state.copyWith(mustIncludeIngredient: ingredient);
    // Hapus _applyFilters();
  }

  void setMustNotIncludeIngredient(String ingredient) {
    state = state.copyWith(mustNotIncludeIngredient: ingredient);
    // Hapus _applyFilters();
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
    // Hapus _applyFilters();
  }

  // === CRUD (Modifikasi) ===
  // Ubah menjadi async dan panggil Firebase
  
  Future<void> addRecipe(Recipe recipe) async {
    // Model Recipe Anda sudah punya .toJson(), itu sempurna! [cite: 1103-1106]
    await _recipesCollection.add(recipe.toJson());
    // StreamBuilder akan otomatis update UI, jadi tidak perlu _loadRecipes()
  }

  Future<void> updateRecipe(Recipe recipe) async {
    // Gunakan recipe.id untuk update dokumen [cite: 1376, 1459]
    await _recipesCollection.doc(recipe.id).update(recipe.toJson());
  }

  Future<void> deleteRecipe(String id) async {
    // Gunakan id untuk hapus dokumen [cite: 1476, 1518]
    await _recipesCollection.doc(id).delete();
  }

  // HAPUS FUNGSI _applyFilters()
  // Logika filter akan kita pindahkan ke UI (HomeScreen)
}

// --- PROVIDER ---
// Provider ini sudah kita ubah di file providers/home_provider.dart