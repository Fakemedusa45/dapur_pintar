// lib/application/providers/home_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// --- ENUM DEFINITIONS ---
enum DifficultyFilter { mudah, sedang, sulit }
enum CategoryFilter { sarapan, makanSiang, makanMalam, dessert }

/// --- STATE CLASS ---
class HomeState {

  final String searchQuery;
  final int? maxDuration;
  final DifficultyFilter? difficulty;
  final CategoryFilter? category;
  final String mustIncludeIngredient;
  final String mustNotIncludeIngredient;
  final List<String> scannedIngredients;

  const HomeState({
    this.searchQuery = '',
    this.maxDuration,
    this.difficulty,
    this.category,
    this.mustIncludeIngredient = '',
    this.mustNotIncludeIngredient = '',
    this.scannedIngredients = const [],
  });

  /// CopyWith with optional null-replacement handling
  HomeState copyWith({
    String? searchQuery,
    int? maxDuration,
    DifficultyFilter? difficulty,
    CategoryFilter? category,
    String? mustIncludeIngredient,
    String? mustNotIncludeIngredient,
    List<String>? scannedIngredients,
  }) {
    return HomeState(
      searchQuery: searchQuery ?? this.searchQuery,
      maxDuration: maxDuration ?? this.maxDuration,
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
      mustIncludeIngredient: mustIncludeIngredient ?? this.mustIncludeIngredient,
      mustNotIncludeIngredient: mustNotIncludeIngredient ?? this.mustNotIncludeIngredient,
      scannedIngredients: scannedIngredients ?? this.scannedIngredients,
    );
  }
}

/// --- NOTIFIER CLASS (Modifikasi) ---
class HomeNotifier extends StateNotifier<HomeState> {

  //  REFERENSI COLLECTION FIREBASE
  final CollectionReference _recipesCollection =
      FirebaseFirestore.instance.collection('recipes');

  HomeNotifier()
      : super(const HomeState()) {
    // HAPUS _loadRecipes();
  }

  // === SETTERS ===
  
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setMaxDuration(int? duration) {
    state = state.copyWith(maxDuration: duration);
  }

  void setDifficulty(DifficultyFilter? filter) {
    state = state.copyWith(difficulty: filter);
  }

  void setCategory(CategoryFilter? filter) {
    state = state.copyWith(category: filter);
  }

  void setMustIncludeIngredient(String ingredient) {
    state = state.copyWith(mustIncludeIngredient: ingredient);
  }

  void setMustNotIncludeIngredient(String ingredient) {
    state = state.copyWith(mustNotIncludeIngredient: ingredient);
  }

  // --- TAMBAHKAN SETTER BARU INI ---
  void setScannedIngredients(List<String> ingredients) {
    state = state.copyWith(scannedIngredients: ingredients);
  }
  // --- END ---

  void resetFilters() {
    state = state.copyWith(
      searchQuery: '',
      maxDuration: null,
      difficulty: null,
      category: null,
      mustIncludeIngredient: '',
      mustNotIncludeIngredient: '',
      scannedIngredients: [],
    );
  }

  // === CRUD  ===
  
  Future<void> addRecipe(Recipe recipe) async {
    // Model Recipe Anda sudah punya .toJson(), itu sempurna! 
    await _recipesCollection.add(recipe.toJson());
  }

  Future<void> updateRecipe(Recipe recipe) async {
    // Gunakan recipe.id untuk update dokumen
    await _recipesCollection.doc(recipe.id).update(recipe.toJson());
  }

  Future<void> deleteRecipe(String id) async {
    // Gunakan id untuk hapus dokumen
    await _recipesCollection.doc(id).delete();
  }

  // HAPUS FUNGSI _applyFilters()
  // Logika filter  dipindahkan ke UI (HomeScreen)
}

// --- PROVIDER ---
// Provider ini sudah diubah di file providers/home_provider.dart