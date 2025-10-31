import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';  // For GoRouter navigation
import 'package:dapur_pintar/application/providers/saved_recipes_provider.dart';
import 'package:dapur_pintar/presentation/widgets/recipe_card.dart';
import 'package:dapur_pintar/presentation/widgets/empty_state.dart';
import 'package:dapur_pintar/core/utils/responsive.dart';
import 'package:dapur_pintar/presentation/routes/app_router.dart';  // For AppRouter constants
import 'package:dapur_pintar/presentation/screens/home_screen.dart';  // For HomeContent (now public)
import 'package:dapur_pintar/presentation/screens/scan_screen.dart';  // For ScanScreen


class SavedRecipesScreen extends StatefulWidget {
  @override
  _SavedRecipesScreenState createState() => _SavedRecipesScreenState();
}

class _SavedRecipesScreenState extends State<SavedRecipesScreen> {
  int _selectedIndex = 1;  // Default to "Saved" tab (index 1)

  static final List<Widget> _screens = <Widget>[
    HomeContent(),  // Home content (recipes) - Now public
    SavedContent(),  // Saved recipes content
    ScanScreen(),    // Scan screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Use GoRouter to navigate (replace current route)
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
      appBar: AppBar(
        title: Text('Resep Tersimpan'),
      ),
      body: _screens[_selectedIndex],  // Display the selected screen
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
      ),
    );
  }
}

// Separate widget for the saved recipes content (to keep it clean)
class SavedContent extends ConsumerWidget {  // Renamed from _SavedContent
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
                    // Use GoRouter to push to detail (stacks on top)
                    context.push(AppRouter.recipeDetail, extra: recipe);
                  },
                ),
    );
  }
}