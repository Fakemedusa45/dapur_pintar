import 'package:hive_flutter/hive_flutter.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';

class RecipeLocalRepository {
  static const String _boxName = 'saved_recipes';

  Future<Box<Recipe>> _getBox() async {
    return Hive.openBox<Recipe>(_boxName);
  }

  Future<void> saveRecipe(Recipe recipe) async {
    final box = await _getBox();
    await box.put(recipe.id, recipe);
  }

  Future<void> removeRecipe(String id) async {
    final box = await _getBox();
    await box.delete(id);
  }

  Future<List<Recipe>> getAllRecipes() async {
    final box = await _getBox();
    return box.values.toList();
  }

  Future<bool> isRecipeSaved(String id) async {
    final box = await _getBox();
    return box.containsKey(id);
  }
}