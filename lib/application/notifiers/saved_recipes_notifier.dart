import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';
import 'package:dapur_pintar/infrastructure/local/recipe_local_repository.dart';

// --- Definisi Kelas SavedRecipesState DIPERBAIKI ---
class SavedRecipesState {
  final List<Recipe> savedRecipes;
  final bool isLoading;

  SavedRecipesState({
    required this.savedRecipes,
    this.isLoading = false,
  });

  // Metode copyWith DITAMBAHKAN
  SavedRecipesState copyWith({
    List<Recipe>? savedRecipes,
    bool? isLoading,
  }) {
    return SavedRecipesState(
      savedRecipes: savedRecipes ?? this.savedRecipes,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
// --- Akhir Definisi Kelas SavedRecipesState ---

// --- Kelas SavedRecipesNotifier Tetap Sama ---
class SavedRecipesNotifier extends StateNotifier<SavedRecipesState> {
  final RecipeLocalRepository _repository;

  SavedRecipesNotifier(this._repository) : super(SavedRecipesState(savedRecipes: [])) {
    loadSavedRecipes();
  }

  Future<void> loadSavedRecipes() async {
    state = state.copyWith(isLoading: true);
    try {
      final recipes = await _repository.getAllRecipes();
      state = state.copyWith(savedRecipes: recipes, isLoading: false);
    } catch (e) {
      print('Error loading saved recipes: $e');
      state = state.copyWith(isLoading: false); 
    }
  }

  Future<void> saveRecipe(Recipe recipe) async {
    try {
      await _repository.saveRecipe(recipe);
      await loadSavedRecipes(); 
    } catch (e) {
      print('Error saving recipe: $e');
    }
  }

  Future<void> removeRecipe(String id) async {
    try {
      await _repository.removeRecipe(id);
      await loadSavedRecipes(); // Refresh list
    } catch (e) {
      print('Error removing recipe: $e');
    }
  }

  Future<bool> isRecipeSaved(String id) async {
    try {
      return await _repository.isRecipeSaved(id);
    } catch (e) {
      print('Error checking if recipe is saved: $e');
      return false;
    }
  }
}
// --- Akhir Kelas SavedRecipesNotifier ---