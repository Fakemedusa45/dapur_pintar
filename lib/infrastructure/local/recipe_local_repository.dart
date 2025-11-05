import 'dart:convert';  // Untuk jsonEncode dan jsonDecode
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';

class RecipeLocalRepository {
  static const String _recipesKey = 'saved_recipes';  // Key untuk menyimpan list resep sebagai JSON

  // Helper untuk mendapatkan SharedPreferences
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // Get all recipes: Decode dari JSON string
  Future<List<Recipe>> getAllRecipes() async {
    try {
      final prefs = await _getPrefs();
      final recipesJson = prefs.getString(_recipesKey);
      if (recipesJson == null) return [];  // Jika belum ada data, return list kosong
      final List<dynamic> decoded = jsonDecode(recipesJson);
      return decoded.map((e) => Recipe.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load recipes: $e');
    }
  }

  // Save recipe: Add atau update, lalu simpan ulang list sebagai JSON
  Future<void> saveRecipe(Recipe recipe) async {
    try {
      final prefs = await _getPrefs();
      final recipes = await getAllRecipes();  // Ambil list saat ini
      final index = recipes.indexWhere((r) => r.id == recipe.id);
      if (index != -1) {
        recipes[index] = recipe;  // Update jika sudah ada
      } else {
        recipes.add(recipe);  // Add jika baru
      }
      final encoded = jsonEncode(recipes.map((r) => r.toJson()).toList());  // Encode ke JSON
      await prefs.setString(_recipesKey, encoded);
    } catch (e) {
      throw Exception('Failed to save recipe: $e');
    }
  }

  // Remove recipe: Hapus dari list, lalu simpan ulang
  Future<void> removeRecipe(String id) async {
    try {
      final prefs = await _getPrefs();
      final recipes = await getAllRecipes();
      recipes.removeWhere((r) => r.id == id);
      final encoded = jsonEncode(recipes.map((r) => r.toJson()).toList());
      await prefs.setString(_recipesKey, encoded);
    } catch (e) {
      throw Exception('Failed to remove recipe: $e');
    }
  }

  // Check if recipe is saved
  Future<bool> isRecipeSaved(String id) async {
    try {
      final recipes = await getAllRecipes();
      return recipes.any((r) => r.id == id);
    } catch (e) {
      throw Exception('Failed to check if recipe is saved: $e');
    }
  }
}