import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';
import 'package:dapur_pintar/application/providers/saved_recipes_provider.dart';
import 'package:dapur_pintar/core/utils/responsive.dart';

class RecipeDetailScreen extends ConsumerWidget {
  final Recipe recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(savedRecipesNotifierProvider.select((state) => state.savedRecipes.any((r) => r.id == recipe.id)));

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: [
          IconButton(
            onPressed: () async {
              final notifier = ref.read(savedRecipesNotifierProvider.notifier);
              if (isSaved) {
                await notifier.removeRecipe(recipe.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Resep dihapus dari simpanan')));
                }
              } else {
                await notifier.saveRecipe(recipe);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Resep disimpan')));
                }
              }
            },
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: isSaved ? Colors.orange : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ResponsiveUtil.getHorizontalPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 16),
            Text(
              recipe.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time),
                SizedBox(width: 4),
                Text('${recipe.duration} menit'),
                SizedBox(width: 16),
                Icon(Icons.flag, size: 14),
                SizedBox(width: 4),
                Text(recipe.difficulty),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Bahan-bahan:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ...recipe.ingredients.map((ing) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text('• $ing'),
                )),
            SizedBox(height: 16),
            Text(
              'Langkah-langkah:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ...recipe.steps.asMap().entries.map((entry) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text('${entry.key + 1}. ${entry.value}'),
                )),
          ],
        ),
      ),
    );
  }
}