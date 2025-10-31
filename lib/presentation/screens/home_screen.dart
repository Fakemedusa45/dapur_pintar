import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';  // Add this import
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

  static final List<Widget> _screens = <Widget>[
    HomeContent(),
    SavedRecipesScreen(),
    ScanScreen(),
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
        title: Text('Dapur Pintar'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => FilterBottomSheet(),
              );
            },
            icon: Icon(Icons.filter_alt),
          ),
        ],
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
      ),
    );
  }
}

class HomeContent extends ConsumerWidget {  // Renamed from _HomeContent
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifierProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtil.getHorizontalPadding(context)),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari resep...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => ref.read(homeNotifierProvider.notifier).setSearchQuery(value),
          ),
          SizedBox(height: 16),
          Expanded(
            child: state.filteredRecipes.isEmpty
                ? Center(child: Text('Tidak ada resep yang ditemukan.'))
                : ResponsiveGrid(
                    recipeList: state.filteredRecipes,
                    onRecipeTap: (recipe) {
                      // Use GoRouter to push to detail (stacks on top)
                      context.push(AppRouter.recipeDetail, extra: recipe);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}