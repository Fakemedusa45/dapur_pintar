import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dapur_pintar/application/providers/home_provider.dart';
import 'package:dapur_pintar/application/notifiers/home_notifier.dart';

class FilterBottomSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifierProvider);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Filter Pencarian',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              // Waktu Memasak
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Waktu Memasak (menit)'),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => ref.read(homeNotifierProvider.notifier).setMaxDuration(30),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: state.maxDuration == 30 ? Colors.orange : null,
                              foregroundColor: state.maxDuration == 30 ? Colors.white : null,
                            ),
                            child: Text('< 30'),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => ref.read(homeNotifierProvider.notifier).setMaxDuration(60),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: state.maxDuration == 60 ? Colors.orange : null,
                              foregroundColor: state.maxDuration == 60 ? Colors.white : null,
                            ),
                            child: Text('30 - 60'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Tingkat Kesulitan
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tingkat Kesulitan'),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => ref.read(homeNotifierProvider.notifier).setDifficulty(DifficultyFilter.mudah),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: state.difficulty == DifficultyFilter.mudah ? Colors.orange : null,
                              foregroundColor: state.difficulty == DifficultyFilter.mudah ? Colors.white : null,
                            ),
                            child: Text('Mudah'),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => ref.read(homeNotifierProvider.notifier).setDifficulty(DifficultyFilter.sedang),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: state.difficulty == DifficultyFilter.sedang ? Colors.orange : null,
                              foregroundColor: state.difficulty == DifficultyFilter.sedang ? Colors.white : null,
                            ),
                            child: Text('Sedang'),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => ref.read(homeNotifierProvider.notifier).setDifficulty(DifficultyFilter.sulit),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: state.difficulty == DifficultyFilter.sulit ? Colors.orange : null,
                              foregroundColor: state.difficulty == DifficultyFilter.sulit ? Colors.white : null,
                            ),
                            child: Text('Sulit'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Kategori
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kategori'),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => ref.read(homeNotifierProvider.notifier).setCategory(CategoryFilter.sarapan),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: state.category == CategoryFilter.sarapan ? Colors.orange : null,
                              foregroundColor: state.category == CategoryFilter.sarapan ? Colors.white : null,
                            ),
                            child: Text('Sarapan'),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => ref.read(homeNotifierProvider.notifier).setCategory(CategoryFilter.makanMalam),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: state.category == CategoryFilter.makanMalam ? Colors.orange : null,
                              foregroundColor: state.category == CategoryFilter.makanMalam ? Colors.white : null,
                            ),
                            child: Text('Makan Malam'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Bahan
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Harus Ada Bahan'),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Contoh: Ayam',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => ref.read(homeNotifierProvider.notifier).setMustIncludeIngredient(value),
                      controller: TextEditingController(text: state.mustIncludeIngredient),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tidak Boleh Ada Bahan'),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Contoh: Bawang Merah',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => ref.read(homeNotifierProvider.notifier).setMustNotIncludeIngredient(value),
                      controller: TextEditingController(text: state.mustNotIncludeIngredient),
                    ),
                  ],
                ),
              ),
              // Reset Button
              Padding(
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(homeNotifierProvider.notifier).resetFilters();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Reset Semua Filter'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}