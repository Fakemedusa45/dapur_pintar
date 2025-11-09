import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';  
import 'package:dapur_pintar/application/providers/home_provider.dart';
import 'package:dapur_pintar/presentation/widgets/recipe_card.dart';
import 'package:dapur_pintar/presentation/widgets/filter_bottom_sheet.dart';
import 'package:dapur_pintar/core/utils/responsive.dart';

import 'package:go_router/go_router.dart';
import 'package:dapur_pintar/application/providers/home_provider.dart';
import 'package:dapur_pintar/presentation/widgets/recipe_card.dart';
import 'package:dapur_pintar/presentation/widgets/filter_bottom_sheet.dart';
>>>>>>> e966c1c (UI DONE KAYANYA)
import 'package:dapur_pintar/presentation/routes/app_router.dart';
import 'package:dapur_pintar/presentation/screens/saved_recipes_screen.dart';
import 'package:dapur_pintar/presentation/screens/scan_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
<<<<<<< HEAD
=======
  const HomeScreen({super.key});

>>>>>>> e966c1c (UI DONE KAYANYA)
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
<<<<<<< HEAD
    HomeContent(),
    SavedRecipesScreen(),
    ScanScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
=======
    const HomeContent(),
    const SavedRecipesScreen(),
    const ScanScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
>>>>>>> e966c1c (UI DONE KAYANYA)
    switch (index) {
      case 0:
        context.go(AppRouter.home);
        break;
      case 1:
        context.go(AppRouter.saved);
        break;
      case 2:
        context.go(AppRouter.scan);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      appBar: AppBar(
        title: Text('Dapur Pintar'),
        backgroundColor: Color(0xFF4CAF50),  
        elevation: 4, 
=======
    // responsive metrics
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final isTablet = width > 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Dapur Pintar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 2,
>>>>>>> e966c1c (UI DONE KAYANYA)
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
<<<<<<< HEAD
                builder: (context) => FilterBottomSheet(),
              );
            },
            icon: Icon(Icons.filter_alt, color: Colors.white), 
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F5E8), Color(0xFFF1F8E9)], 
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
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
        selectedItemColor: Color(0xFF4CAF50),  
        unselectedItemColor: Colors.grey,  
        backgroundColor: Colors.white, 
        elevation: 8,  
        onTap: _onItemTapped,
      ),
      // Floating Action Button untuk add resep baru (diperbaiki)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate ke add recipe screen dengan extra: null (untuk add baru)
          context.push(AppRouter.addEditRecipe, extra: null);
        },
        backgroundColor: Color(0xFF4CAF50),  // Warna hijau sesuai tema
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'Tambah Resep Baru',  // Untuk aksesibilitas
=======
                shape: const RoundedRectangleBorder(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (context) => FilterBottomSheet(),
              );
            },
            icon: const Icon(Icons.filter_alt_rounded, color: Colors.white),
            tooltip: "Filter Resep",
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Container(
          key: ValueKey<int>(_selectedIndex),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE8F5E8), Color(0xFFF1F8E9)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: _screens[_selectedIndex],
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: const Color(0x334CAF50),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.star_outline),
              selectedIcon: Icon(Icons.star),
              label: 'Favorit',
            ),
            NavigationDestination(
              icon: Icon(Icons.camera_alt_outlined),
              selectedIcon: Icon(Icons.camera_alt),
              label: 'Pindai',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRouter.addEditRecipe, extra: null),
        backgroundColor: const Color(0xFF4CAF50),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Tambah Resep',
          style: TextStyle(
            fontSize: isTablet ? 18 : 14,
            color: Colors.white,
          ),
        ),
>>>>>>> e966c1c (UI DONE KAYANYA)
      ),
    );
  }
}

<<<<<<< HEAD
class HomeContent extends ConsumerWidget { 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifierProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtil.getHorizontalPadding(context)),
      child: Column(
        children: [
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
=======
class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifierProvider);
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Field
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4CAF50).withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
>>>>>>> e966c1c (UI DONE KAYANYA)
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
<<<<<<< HEAD
                hintText: 'Cari resep...',
                prefixIcon: Icon(Icons.search, color: Color(0xFF4CAF50)),  
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,  
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) => ref.read(homeNotifierProvider.notifier).setSearchQuery(value),
            ),
          ),
          SizedBox(height: 16),

          Row(
            children: [
              Icon(Icons.restaurant_menu, color: Color(0xFFFF9800)), 
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
=======
                hintText: 'Cari resep favoritmu...',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: width * 0.04,
                ),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.search, color: Color(0xFF4CAF50)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  vertical: width * 0.04,
                  horizontal: width * 0.04,
                ),
              ),
              style: TextStyle(fontSize: width * 0.04),
              onChanged: (value) =>
                  ref.read(homeNotifierProvider.notifier).setSearchQuery(value),
            ),
          ),

          // Section Title
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFF9800).withOpacity(0.1),
                  const Color(0xFFFF9800).withOpacity(0.05),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFFF9800).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9800),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF9800).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.restaurant_menu, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  'Resep Terbaru',
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2E7D32),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Recipe Grid / Empty State
>>>>>>> e966c1c (UI DONE KAYANYA)
          Expanded(
            child: state.filteredRecipes.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
<<<<<<< HEAD
                        Icon(Icons.no_food, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Tidak ada resep yang ditemukan.',
                          style: TextStyle(color: Colors.grey),
=======
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.no_food,
                            size: width * 0.2,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Tidak ada resep yang ditemukan',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Coba cari dengan kata kunci lain',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: width * 0.035,
                          ),
>>>>>>> e966c1c (UI DONE KAYANYA)
                        ),
                      ],
                    ),
                  )
                : ResponsiveGrid(
                    recipeList: state.filteredRecipes,
                    onRecipeTap: (recipe) {
<<<<<<< HEAD
                     
=======
>>>>>>> e966c1c (UI DONE KAYANYA)
                      context.push(AppRouter.recipeDetail, extra: recipe);
                    },
                  ),
          ),
        ],
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> e966c1c (UI DONE KAYANYA)
