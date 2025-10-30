import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dapur_pintar/application/providers/saved_recipes_provider.dart';
import 'package:dapur_pintar/presentation/widgets/recipe_card.dart';
import 'package:dapur_pintar/presentation/widgets/empty_state.dart';
import 'package:dapur_pintar/core/utils/responsive.dart';

class SavedRecipesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(savedRecipesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Resep Tersimpan'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveUtil.getHorizontalPadding(context)),
        child: state.isLoading
            ? Center(child: CircularProgressIndicator())
            : state.savedRecipes.isEmpty
                ? EmptyState(message: 'Anda belum menyimpan resep apapun.')
                : ResponsiveGrid(recipeList: state.savedRecipes), // Widget sekarang bisa digunakan
      ),
    );
  }
}