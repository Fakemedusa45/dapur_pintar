import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dapur_pintar/presentation/screens/home_screen.dart';
import 'package:dapur_pintar/presentation/screens/scan_screen.dart';
import 'package:dapur_pintar/presentation/screens/saved_recipes_screen.dart';
import 'package:dapur_pintar/presentation/screens/recipe_detail_screen.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';
import 'package:dapur_pintar/presentation/screens/add_edit_recipe_screen.dart';

class AppRouter {
  static const String home = '/home';
  static const String scan = '/scan';
  static const String saved = '/saved';
  static const String recipeDetail = '/detail';
  static const String addRecipe = '/add'; // 2. BUAT KONSTANTA BARU
  static const String editRecipe = '/edit'; // 3. BUAT KONSTANTA BARU

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        pageBuilder: (context, state) => MaterialPage(child: HomeScreen()),
      ),
      GoRoute(
        path: scan,
        name: 'scan',
        pageBuilder: (context, state) => MaterialPage(child: ScanScreen()),
      ),
      GoRoute(
        path: saved,
        name: 'saved',
        pageBuilder: (context, state) => MaterialPage(child: SavedRecipesScreen()),
      ),
      GoRoute(
        path: recipeDetail,
        name: 'detail',
        pageBuilder: (context, state) {
          final recipe = state.extra as Recipe?;
          if (recipe == null) {
            // Fallback if no recipe is passed (e.g., show error or redirect)
            return MaterialPage(child: Scaffold(body: Center(child: Text('Recipe not found'))));
          }
          return MaterialPage(child: RecipeDetailScreen(recipe: recipe));
        },
      ),

      GoRoute(
        path: addRecipe,
        name: 'add',
        pageBuilder: (context, state) => MaterialPage(
          child: AddEditRecipeScreen(recipe: null), // Kirim null karena ini resep baru
        ),
      ),
      // Rute untuk mode 'Update' (Edit)
      GoRoute(
        path: editRecipe,
        name: 'edit',
        pageBuilder: (context, state) => MaterialPage(
          child: AddEditRecipeScreen(recipe: state.extra as Recipe), // Kirim resep yang ada
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(body: Center(child: Text('Page not found'))),
    ),
  );
}