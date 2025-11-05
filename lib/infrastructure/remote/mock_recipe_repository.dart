// lib/infrastructure/remote/mock_recipe_repository.dart

import 'package:dapur_pintar/domain/models/recipe.dart';

class MockRecipeRepository {
  List<Recipe> _recipes = [
    Recipe(
      id: '1',
      title: 'Nasi Goreng Sederhana',
      imageUrl: 'assets/images/nasi_goreng.jpeg', 
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
      imageUrl: 'assets/images/omelet.jpg', 
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
      imageUrl: 'assets/images/sup_sayur.jpeg',  
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
      imageUrl: 'assets/images/salad_buah.jpg', 
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
    return _recipes;
  }
  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
  }


  void updateRecipe(Recipe updatedRecipe) {
  final index = _recipes.indexWhere((recipe) => recipe.id == updatedRecipe.id);
  if (index != -1) {
    _recipes[index] = updatedRecipe; // GANTI OBJEK LAMA DENGAN YANG BARU
  }
}
  void deleteRecipe(String id) {
    _recipes.removeWhere((recipe) => recipe.id == id);
  }
}