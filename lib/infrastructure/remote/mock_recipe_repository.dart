// lib/infrastructure/remote/mock_recipe_repository.dart

import 'package:dapur_pintar/domain/models/recipe.dart';

class MockRecipeRepository {
  // 1. HAPUS 'final' agar list bisa diubah
  List<Recipe> _recipes = [
    Recipe(
      id: '1',
      title: 'Nasi Goreng Sederhana',
      imageUrl: 'https://example.com/nasi_goreng.jpg',
      duration: 15,
      difficulty: 'Mudah',
      category: 'Makan Malam',
      ingredients: ['Nasi', 'Telur', 'Bawang Putih', 'Kecap Manis'],
      steps: [
        'Tumis bawang putih hingga harum.',
        'Masukkan telur, aduk hingga matang.',
        'Masukkan nasi, aduk rata.',
        'Tambahkan kecap manis, aduk hingga matang.'
      ],
    ),
    Recipe(
      id: '2',
      title: 'Omelet Telur',
      imageUrl: 'https://example.com/omelet.jpg',
      duration: 10,
      difficulty: 'Mudah',
      category: 'Sarapan',
      ingredients: ['Telur', 'Garam', 'Lada', 'Susu'],
      steps: [
        'Kocok telur, garam, lada, dan sedikit susu.',
        'Panaskan wajan, tuangkan adonan.',
        'Masak hingga matang, lipat dan sajikan.'
      ],
    ),
    Recipe(
      id: '3',
      title: 'Sup Sayur',
      imageUrl: 'https://example.com/sup_sayur.jpg',
      duration: 30,
      difficulty: 'Sedang',
      category: 'Makan Siang',
      ingredients: ['Wortel', 'Kentang', 'Buncis', 'Kaldu Ayam'],
      steps: [
        'Potong-potong sayuran.',
        'Didihkan kaldu, masukkan sayuran.',
        'Masak hingga empuk, tambahkan garam dan lada.'
      ],
    ),
    Recipe(
      id: '4',
      title: 'Salad Buah',
      imageUrl: 'https://example.com/salad_buah.jpg',
      duration: 10,
      difficulty: 'Mudah',
      category: 'Dessert',
      ingredients: ['Apel', 'Pisang', 'Anggur', 'Madu'],
      steps: [
        'Potong-potong buah-buahan.',
        'Campur dalam mangkuk.',
        'Siram dengan madu.'
      ],
    ),
  ];

  List<Recipe> getRecipes() {
    // 2. Kembalikan list _recipes
    return _recipes;
  }

  // --- 3. TAMBAHKAN FUNGSI DI BAWAH INI ---
  
  // CREATE
  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
  }

  // UPDATE
  void updateRecipe(Recipe updatedRecipe) {
    // Cari index resep yang akan diupdate
    final index = _recipes.indexWhere((recipe) => recipe.id == updatedRecipe.id);
    if (index != -1) {
      // Ganti resep di index tersebut dengan data baru
      _recipes[index] = updatedRecipe;
    }
  }

  // DELETE
  void deleteRecipe(String id) {
    _recipes.removeWhere((recipe) => recipe.id == id);
  }
}