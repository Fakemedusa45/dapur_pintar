import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

// Providers & Notifiers
import 'package:dapur_pintar/application/providers/scan_provider.dart';
import 'package:dapur_pintar/application/notifiers/scan_notifier.dart';
import 'package:dapur_pintar/application/providers/home_provider.dart';

// Screens & Routing
import 'package:dapur_pintar/presentation/routes/app_router.dart';
import 'package:dapur_pintar/presentation/screens/home_screen.dart';
import 'package:dapur_pintar/presentation/screens/saved_recipes_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  int _selectedIndex = 2;

  static final List<Widget> _screens = <Widget>[
    HomeContent(),
    SavedContent(),
    _ScanContent(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Pindai Bahan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
      ),
    );
  }
}

class _ScanContent extends ConsumerWidget {
  const _ScanContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scanNotifierProvider);
    final width = MediaQuery.of(context).size.width;

    if (state.error != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(width * 0.06),
          child: Text(
            'Terjadi kesalahan:\n${state.error}',
            style: TextStyle(
              color: Colors.red[700],
              fontWeight: FontWeight.w500,
              fontSize: width * 0.04,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (state.isProcessing) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF4CAF50)),
      );
    }

    if (state.detectedIngredients != null) {
      return _buildResults(context, ref, state.detectedIngredients!);
    }

    // GANTI return _buildCaptureView(...)
    return _buildPickerView(context, ref, state, width);
  }

  // HAPUS SELURUH WIDGET _buildCaptureView
  // ...

  // TAMBAHKAN WIDGET BARU _buildPickerView
  Widget _buildPickerView(
      BuildContext context, WidgetRef ref, ScanState state, double width) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE8F5E8), Color(0xFFF1F8E9)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // 1. Tombol Pilihan
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => ref
                      .read(scanNotifierProvider.notifier)
                      .pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Galeri'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => ref
                      .read(scanNotifierProvider.notifier)
                      .pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Kamera'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 2. Judul "Foto Dipilih"
          Text(
            'Bahan untuk dipindai:',
            style: TextStyle(fontSize: width * 0.045, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // 3. List Thumbnail
          if (state.capturedImages.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_search, size: 60, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'Ambil gambar dari galeri atau kamera',
                      style: TextStyle(color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            // Container untuk menampung Listview
            Container(
              height: width * 0.3, // Beri tinggi agar tidak error
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.capturedImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(state.capturedImages[index].path),
                            width: width * 0.25,
                            height: width * 0.25,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: -4,
                          right: -4,
                          child: GestureDetector(
                            onTap: () => ref
                                .read(scanNotifierProvider.notifier)
                                .removeImage(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.redAccent.withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(4),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

          // Spacer agar tombol "Pindai" ke bawah
          const Spacer(), 

          // 4. Tombol Proses
          if (state.capturedImages.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: FilledButton.icon(
                icon: const Icon(Icons.check, color: Colors.white),
                label: Text('Pindai (${state.capturedImages.length}) Bahan',
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.1, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () =>
                    ref.read(scanNotifierProvider.notifier).processImages(),
              ),
            ),
        ],
      ),
    );
  }
  // --- AKHIR WIDGET _buildPickerView ---

  // Widget _buildResults tetap sama
  Widget _buildResults(
      BuildContext context, WidgetRef ref, List<String> ingredients) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, size: 80, color: Color(0xFF4CAF50)),
          const SizedBox(height: 16),
          Text(
            'Bahan Terdeteksi:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: width * 0.05,
              color: const Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: ingredients
                .map(
                  (ing) => Chip(
                    label: Text(ing),
                    backgroundColor: const Color(0xFFE8F5E9),
                    labelStyle: const TextStyle(color: Color(0xFF2E7D32)),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.08,
                vertical: width * 0.04,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              // final ingredientString = ingredients.join(', ');
              ref
                  .read(homeNotifierProvider.notifier)
                  .setScannedIngredients(ingredients);
              ref.read(scanNotifierProvider.notifier).resetDetection();
              
              // Pergi ke Home Screen
              context.go(AppRouter.home);
              
              // Catatan: Kode Anda sebelumnya menggunakan pushNamedAndRemoveUntil,
              // tapi karena Anda pakai GoRouter, 'context.go()' sudah
              // benar untuk mengganti halaman.
            },
            icon: const Icon(Icons.search, color: Colors.white),
            label: const Text(
              'Cari Resep Berdasarkan Bahan Ini',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}