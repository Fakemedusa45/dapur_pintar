import 'package:dapur_pintar/domain/models/recipe.dart';

class MockRecipeRepository {
  List<Recipe> getRecipes() {
    return [
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
  }
}