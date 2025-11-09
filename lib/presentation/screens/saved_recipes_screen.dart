import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
<<<<<<< HEAD
import 'package:go_router/go_router.dart';  
import 'package:dapur_pintar/application/providers/saved_recipes_provider.dart';
import 'package:dapur_pintar/presentation/widgets/recipe_card.dart';
import 'package:dapur_pintar/presentation/widgets/empty_state.dart';
import 'package:dapur_pintar/core/utils/responsive.dart';
import 'package:dapur_pintar/presentation/routes/app_router.dart'; 
import 'package:dapur_pintar/presentation/screens/home_screen.dart'; 
import 'package:dapur_pintar/presentation/screens/scan_screen.dart';  

class SavedRecipesScreen extends StatefulWidget {
  @override
  _SavedRecipesScreenState createState() => _SavedRecipesScreenState();
}

class _SavedRecipesScreenState extends State<SavedRecipesScreen> {
  int _selectedIndex = 1;  

  static final List<Widget> _screens = <Widget>[
    HomeContent(),  
    SavedContent(), 
    ScanScreen(),  
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
=======
import 'package:go_router/go_router.dart';
import 'package:dapur_pintar/application/providers/saved_recipes_provider.dart';
import 'package:dapur_pintar/presentation/widgets/recipe_card.dart';
import 'package:dapur_pintar/presentation/widgets/empty_state.dart';
import 'package:dapur_pintar/presentation/routes/app_router.dart';
import 'package:dapur_pintar/presentation/screens/home_screen.dart';
import 'package:dapur_pintar/presentation/screens/scan_screen.dart';

class SavedRecipesScreen extends StatefulWidget {
  const SavedRecipesScreen({super.key});

  @override
  State<SavedRecipesScreen> createState() => _SavedRecipesScreenState();
}

class _SavedRecipesScreenState extends State<SavedRecipesScreen> {
  int _selectedIndex = 1;

  static final List<Widget> _screens = <Widget>[
    const HomeContent(),
    const SavedContent(),
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
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(
        title: Text('Resep Tersimpan'),
      ),
      body: _screens[_selectedIndex],  
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
        onTap: _onItemTapped,
=======
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Resep Favorit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_selectedIndex],
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
>>>>>>> e966c1c (UI DONE KAYANYA)
      ),
    );
  }
}

<<<<<<< HEAD
class SavedContent extends ConsumerWidget { 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(savedRecipesNotifierProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtil.getHorizontalPadding(context)),
      child: state.isLoading
          ? Center(child: CircularProgressIndicator())
          : state.savedRecipes.isEmpty
              ? EmptyState(message: 'Anda belum menyimpan resep apapun.')
              : ResponsiveGrid(
                  recipeList: state.savedRecipes,
                  onRecipeTap: (recipe) {
                   
                    context.push(AppRouter.recipeDetail, extra: recipe);
                  },
                ),
    );
  }
}
=======
class SavedContent extends ConsumerWidget {
  const SavedContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(savedRecipesNotifierProvider);
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE8F5E8), Color(0xFFF1F8E9)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 12),
        child: state.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF4CAF50),
                ),
              )
            : state.savedRecipes.isEmpty
                ? const EmptyState(
                    message: 'Anda belum menambahkan resep favorit apapun.',
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFFFF9800).withOpacity(0.15),
                              const Color(0xFFFF9800).withOpacity(0.05),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFFF9800).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF9800).withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.star, color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Daftar Resep Favorit',
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
                      Expanded(
                        child: ResponsiveGrid(
                          recipeList: state.savedRecipes,
                          onRecipeTap: (recipe) {
                            context.push(AppRouter.recipeDetail, extra: recipe);
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
>>>>>>> e966c1c (UI DONE KAYANYA)
