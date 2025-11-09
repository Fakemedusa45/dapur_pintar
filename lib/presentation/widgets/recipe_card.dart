import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';  
import 'package:dapur_pintar/domain/models/recipe.dart';
import 'package:dapur_pintar/presentation/routes/app_router.dart';
import 'package:dapur_pintar/core/utils/responsive.dart';
import 'dart:io';

<<<<<<< HEAD
class RecipeCard extends StatelessWidget {
=======
class RecipeCard extends StatefulWidget {
>>>>>>> e966c1c (UI DONE KAYANYA)
  final Recipe recipe;
  final VoidCallback? onTap; 
  const RecipeCard({
    Key? key,
    required this.recipe,
    this.onTap,
  }) : super(key: key);

  @override
<<<<<<< HEAD
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
=======
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap ?? () {
                  context.push(AppRouter.recipeDetail, extra: widget.recipe);
                },
                onTapDown: (_) {
                  _controller.forward();
                },
                onTapUp: (_) {
                  _controller.reverse();
                },
                onTapCancel: () {
                  _controller.reverse();
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: widget.recipe.imageUrl.startsWith('assets/')
                                  ? Image.asset(
                                      widget.recipe.imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return _errorImagePlaceholder();
                                      },
                                    )
                                  : Image.file(
                                      File(widget.recipe.imageUrl),
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return _errorImagePlaceholder();
                                      },
                                    ),
                            ),
                            // Gradient overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.3),
                                    ],
                                    stops: const [0.6, 1.0],
                                  ),
                                ),
                              ),
                            ),
                            // Info badges on image
                            Positioned(
                              bottom: 12,
                              left: 12,
                              right: 12,
                              child: Row(
                                children: [
                                  _buildInfoBadge(
                                    Icons.access_time,
                                    '${widget.recipe.duration} min',
                                    Colors.white.withOpacity(0.9),
                                  ),
                                  const SizedBox(width: 8),
                                  _buildInfoBadge(
                                    Icons.flag,
                                    widget.recipe.difficulty,
                                    Colors.white.withOpacity(0.9),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.recipe.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32),
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.recipe.category,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoBadge(IconData icon, String text, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF2E7D32)),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2E7D32),
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorImagePlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: Icon(
        Icons.image_not_supported,
        size: 50,
        color: Colors.grey[600],
>>>>>>> e966c1c (UI DONE KAYANYA)
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
<<<<<<< HEAD
=======
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
>>>>>>> e966c1c (UI DONE KAYANYA)
        itemCount: recipeList.length,
        itemBuilder: (context, index) => RecipeCard(
          recipe: recipeList[index],
          onTap: onRecipeTap != null ? () => onRecipeTap!(recipeList[index]) : null,
        ),
      );
    } else {
      return GridView.builder(
<<<<<<< HEAD
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ResponsiveUtil.isTablet(context) ? 2 : 3,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
=======
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ResponsiveUtil.isTablet(context) ? 2 : 3,
          childAspectRatio: 0.75,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
>>>>>>> e966c1c (UI DONE KAYANYA)
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
