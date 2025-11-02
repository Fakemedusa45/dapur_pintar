import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';  // For GoRouter navigation
import 'package:dapur_pintar/domain/models/recipe.dart';
import 'package:dapur_pintar/presentation/routes/app_router.dart';
import 'package:dapur_pintar/core/utils/responsive.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onTap;  // Optional callback for custom tap handling

  const RecipeCard({
    Key? key,
    required this.recipe,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap ?? () {
          // Default: Use GoRouter to navigate to recipe detail
          context.push(AppRouter.recipeDetail, extra: recipe);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                recipe.imageUrl,  // Changed from Image.network to Image.asset for local assets
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Handle asset errors (e.g., file not found) by showing a placeholder
                  return Container(
                    color: Colors.grey[300],  // Light gray background
                    child: Icon(
                      Icons.image_not_supported,  // Placeholder icon for missing images
                      size: 50,
                      color: Colors.grey[600],
                    ),
                  );
                },
                // Removed loadingBuilder as it's not needed for local assets (they load instantly)
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 14),
                      SizedBox(width: 4),
                      Text('${recipe.duration} min'),
                      SizedBox(width: 16),
                      Icon(Icons.flag, size: 14),  // Icon for difficulty
                      SizedBox(width: 4),
                      Text(recipe.difficulty),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Widget ResponsiveGrid ---
class ResponsiveGrid extends StatelessWidget {
  final List<Recipe> recipeList;  // Changed to List<Recipe> for type safety
  final Function(Recipe)? onRecipeTap;  // Optional callback for recipe tap

  const ResponsiveGrid({
    Key? key,
    required this.recipeList,
    this.onRecipeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveUtil.isMobile(context)) {
      return ListView.builder(
        itemCount: recipeList.length,
        itemBuilder: (context, index) => RecipeCard(
          recipe: recipeList[index],
          onTap: onRecipeTap != null ? () => onRecipeTap!(recipeList[index]) : null,
        ),
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ResponsiveUtil.isTablet(context) ? 2 : 3,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: recipeList.length,
        itemBuilder: (context, index) => RecipeCard(
          recipe: recipeList[index],
          onTap: onRecipeTap != null ? () => onRecipeTap!(recipeList[index]) : null,
        ),
      );
    }
  }
}
// --- End of ResponsiveGrid ---