import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';  
import 'package:dapur_pintar/domain/models/recipe.dart';
import 'package:dapur_pintar/presentation/routes/app_router.dart';
import 'package:dapur_pintar/core/utils/responsive.dart';
import 'dart:io';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onTap; 
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
          context.push(AppRouter.recipeDetail, extra: recipe);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: recipe.imageUrl.startsWith('assets/')
    ? Image.asset(
        recipe.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: Icon(
              Icons.image_not_supported,
              size: 50,
              color: Colors.grey[600],
            ),
          );
        },
      )
    : Image.file(
        File(recipe.imageUrl),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: Icon(
              Icons.image_not_supported,
              size: 50,
              color: Colors.grey[600],
            ),
          );
        },
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
                      Icon(Icons.flag, size: 14),  
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


class ResponsiveGrid extends StatelessWidget {
  final List<Recipe> recipeList;  
  final Function(Recipe)? onRecipeTap; 

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
