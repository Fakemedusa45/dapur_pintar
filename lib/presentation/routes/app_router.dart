import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dapur_pintar/presentation/screens/home_screen.dart';
import 'package:dapur_pintar/presentation/screens/scan_screen.dart';
import 'package:dapur_pintar/presentation/screens/saved_recipes_screen.dart';
import 'package:dapur_pintar/presentation/screens/recipe_detail_screen.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';

class AppRouter {
  static const String home = '/home';
  static const String scan = '/scan';
  static const String saved = '/saved';
  static const String recipeDetail = '/detail';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) => home,
      ),
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
        pageBuilder: (context, state) => MaterialPage(child: RecipeDetailScreen(recipe: state.extra as Recipe)),
      ),
    ],
  );
}