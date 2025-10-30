import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dapur_pintar/application/providers/home_provider.dart';
import 'package:dapur_pintar/presentation/widgets/recipe_card.dart'; // Import file yang sekarang menyimpan ResponsiveGrid
import 'package:dapur_pintar/presentation/widgets/filter_bottom_sheet.dart';
import 'package:dapur_pintar/core/utils/responsive.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifierProvider);

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
      body: Padding(
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
                  : ResponsiveGrid(recipeList: state.filteredRecipes), // Widget sekarang diimpor dari recipe_card.dart
            ),
          ],
        ),
      ),
    );
  }
}
