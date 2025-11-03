// lib/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dapur_pintar/application/providers/home_provider.dart';
import 'package:dapur_pintar/presentation/widgets/recipe_card.dart';
import 'package:dapur_pintar/presentation/widgets/filter_bottom_sheet.dart';
import 'package:dapur_pintar/core/utils/responsive.dart';
import 'package:dapur_pintar/presentation/routes/app_router.dart';
import 'package:dapur_pintar/presentation/screens/saved_recipes_screen.dart';
import 'package:dapur_pintar/presentation/screens/scan_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  // Daftar layar untuk Bottom Navigation Bar
  static final List<Widget> _screens = <Widget>[
    HomeContent(), // Konten tab Home (Indeks 0)
    SavedRecipesScreen(), // Konten tab Tersimpan (Indeks 1)
    ScanScreen(), // Konten tab Pindai (Indeks 2)
  ];

  void _onItemTapped(int index) {
    // --- PERBAIKAN 1: HAPUS SEMUA context.go() ---
    // Cukup gunakan setState untuk mengganti layar yang ditampilkan di body
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dapur Pintar'),
        backgroundColor: Color(0xFF4CAF50), // Hijau gelap untuk tema dapur segar
        elevation: 4, // Tambah shadow untuk hiasan
        actions: [
          // Hanya tampilkan tombol filter jika sedang di tab Home (indeks 0)
          if (_selectedIndex == 0)
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => FilterBottomSheet(),
                );
              },
              icon: Icon(Icons.filter_alt, color: Colors.white), // Ikon putih untuk kontras
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F5E8), Color(0xFFF1F8E9)], // Gradient hijau muda
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // Tampilkan layar berdasarkan indeks yang dipilih
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Tersimpan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Pindai',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF4CAF50), // Hijau untuk item terpilih
        unselectedItemColor: Colors.grey, // Abu untuk tidak terpilih
        backgroundColor: Colors.white, // Background putih dengan shadow
        elevation: 8, // Tambah shadow
        onTap: _onItemTapped,
      ),

      // --- PERBAIKAN 2: TAMBAHKAN KEMBALI TOMBOL 'ADD' (CRUD) ---
      // Hanya tampilkan tombol '+' jika kita berada di tab Home (indeks 0)
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              heroTag: 'add_button',
              onPressed: () {
                // Navigasi ke halaman Tambah Resep
                context.push(AppRouter.addRecipe);
              },
              backgroundColor: Color(0xFFFF9800), // Warna oranye
              child: Icon(Icons.add, color: Colors.white),
            )
          : null, // Sembunyikan tombol jika tidak di tab Home
    );
  }
}

// --- KONTEN UTAMA TAB HOME ---
// (Ini adalah isi dari HomeScreen Anda sebelumnya)
class HomeContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifierProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtil.getHorizontalPadding(context)),
      child: Column(
        children: [
          // Search Bar dengan Hiasan
          Container(
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari resep...',
                prefixIcon: Icon(Icons.search, color: Color(0xFF4CAF50)), // Ikon hijau
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none, // Hilangkan border default
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) => ref.read(homeNotifierProvider.notifier).setSearchQuery(value),
            ),
          ),
          SizedBox(height: 16),
          // Header "Resep Terbaru"
          Row(
            children: [
              Icon(Icons.restaurant_menu, color: Color(0xFFFF9800)), // Ikon oranye
              SizedBox(width: 8),
              Text(
                'Resep Terbaru',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Grid Daftar Resep
          Expanded(
            child: state.filteredRecipes.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.no_food, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Tidak ada resep yang ditemukan.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ResponsiveGrid(
                    recipeList: state.filteredRecipes,
                    // --- PERBAIKAN 3: HAPUS onRecipeTap ---
                    // Biarkan RecipeCard menangani kliknya sendiri
                    // seperti sebelumnya.
                  ),
          ),
        ],
      ),
    );
  }
}