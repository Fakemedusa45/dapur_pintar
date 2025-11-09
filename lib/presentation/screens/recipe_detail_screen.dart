<<<<<<< HEAD
import 'dart:io';  // Add this import for File
=======
import 'dart:io';
>>>>>>> e966c1c (UI DONE KAYANYA)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';
import 'package:dapur_pintar/application/providers/saved_recipes_provider.dart';
<<<<<<< HEAD
import 'package:dapur_pintar/core/utils/responsive.dart';
=======
>>>>>>> e966c1c (UI DONE KAYANYA)
import 'package:go_router/go_router.dart';

class RecipeDetailScreen extends ConsumerWidget {
  final Recipe recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
<<<<<<< HEAD
    final isSaved = ref.watch(savedRecipesNotifierProvider.select((state) => state.savedRecipes.any((r) => r.id == recipe.id)));

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
=======
    final isSaved = ref.watch(savedRecipesNotifierProvider.select(
      (state) => state.savedRecipes.any((r) => r.id == recipe.id),
    ));

    // Responsive metrics
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final isTablet = width > 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          recipe.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? 24 : 18,
          ),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 2,
>>>>>>> e966c1c (UI DONE KAYANYA)
        actions: [
          // Edit Button
          IconButton(
            tooltip: 'Edit Resep',
            onPressed: () {
<<<<<<< HEAD
              context.pushNamed('add-edit-recipe', extra: recipe);  // Use named route
            },
            icon: Icon(Icons.edit),
          ),
          // Save Button
          IconButton(
            tooltip: isSaved ? 'Hapus dari simpanan' : 'Simpan resep',
=======
              context.pushNamed('add-edit-recipe', extra: recipe);
            },
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
          // Save Button
          IconButton(
            tooltip: isSaved ? 'Hapus dari favorit' : 'Tambah ke favorit',
>>>>>>> e966c1c (UI DONE KAYANYA)
            onPressed: () async {
              final notifier = ref.read(savedRecipesNotifierProvider.notifier);
              try {
                if (isSaved) {
                  await notifier.removeRecipe(recipe.id);
                  if (context.mounted) {
<<<<<<< HEAD
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Resep dihapus dari simpanan')));
=======
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Resep dihapus dari favorit'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
>>>>>>> e966c1c (UI DONE KAYANYA)
                  }
                } else {
                  await notifier.saveRecipe(recipe);
                  if (context.mounted) {
<<<<<<< HEAD
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Resep disimpan')));
=======
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Resep ditambahkan ke favorit'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
>>>>>>> e966c1c (UI DONE KAYANYA)
                  }
                }
              } catch (e) {
                if (context.mounted) {
<<<<<<< HEAD
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal menyimpan resep: $e')));
=======
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal menambahkan ke favorit: $e')),
                  );
>>>>>>> e966c1c (UI DONE KAYANYA)
                }
              }
            },
            icon: Icon(
<<<<<<< HEAD
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: isSaved ? Colors.orange : null,
=======
              isSaved ? Icons.star : Icons.star_border,
              color: isSaved ? Colors.orangeAccent : Colors.white,
>>>>>>> e966c1c (UI DONE KAYANYA)
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
<<<<<<< HEAD
        padding: EdgeInsets.all(ResponsiveUtil.getHorizontalPadding(context)),
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
=======
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    children: [
                      recipe.imageUrl.startsWith('assets/')
                          ? Image.asset(
                              recipe.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _errorImagePlaceholder();
                              },
                            )
                          : Image.file(
                              File(recipe.imageUrl),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _errorImagePlaceholder();
                              },
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
                                Colors.black.withOpacity(0.2),
                              ],
                              stops: const [0.7, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Recipe title
            Text(
              recipe.title,
              style: TextStyle(
                fontSize: isTablet ? 28 : 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 12),

            // Info Row
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _infoChip(Icons.access_time, '${recipe.duration} menit'),
                _infoChip(Icons.flag, recipe.difficulty),
                _infoChip(Icons.category, recipe.category),
              ],
            ),

            const SizedBox(height: 24),

            // Ingredients section
            _sectionHeader('Bahan-bahan'),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: recipe.ingredients
                    .map(
                      (ing) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 6, right: 12),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            ing,
                            style: TextStyle(
                              fontSize: width * 0.04,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                      ),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Steps section
            _sectionHeader('Langkah-langkah'),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: recipe.steps.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 2, right: 12),
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4CAF50).withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '${entry.key + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: TextStyle(
                              fontSize: width * 0.04,
                              color: Colors.black87,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
>>>>>>> e966c1c (UI DONE KAYANYA)
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======

  Widget _errorImagePlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: Icon(
        Icons.image_not_supported,
        size: 60,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4CAF50).withOpacity(0.1),
            const Color(0xFF81C784).withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF4CAF50).withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4CAF50).withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF4CAF50), size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
>>>>>>> e966c1c (UI DONE KAYANYA)
