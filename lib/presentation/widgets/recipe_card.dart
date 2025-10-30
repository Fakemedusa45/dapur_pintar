import 'package:flutter/material.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';
import 'package:dapur_pintar/presentation/routes/app_router.dart';
import 'package:dapur_pintar/core/utils/responsive.dart'; // Pastikan import ini ada

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          AppRouter.recipeDetail,
          arguments: recipe,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
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
                      // Ganti Icons.difficulty dengan ikon yang sesuai
                      Icon(Icons.flag, size: 14), // Misalnya ikon bendera untuk tingkat kesulitan
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

// --- Widget ResponsiveGrid DIPINDAHKAN KE SINI ---
class ResponsiveGrid extends StatelessWidget {
  final List<dynamic> recipeList; // Bisa disesuaikan tipe datanya jika perlu

  const ResponsiveGrid({Key? key, required this.recipeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveUtil.isMobile(context)) {
      return ListView.builder(
        itemCount: recipeList.length,
        itemBuilder: (context, index) => RecipeCard(recipe: recipeList[index]),
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
        itemBuilder: (context, index) => RecipeCard(recipe: recipeList[index]),
      );
    }
  }
}
// --- Akhir Widget ResponsiveGrid ---