import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';

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

    return _buildCaptureView(ref, state, width);
  }

  Widget _buildCaptureView(WidgetRef ref, ScanState state, double width) {
    if (state.controller == null || !state.controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        Positioned.fill(child: CameraPreview(state.controller!)),

        // Thumbnail dari foto yang diambil
        if (state.capturedImages.isNotEmpty)
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: width * 0.25,
              margin: const EdgeInsets.only(top: 16),
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
          ),

        // Tombol aksi di bawah
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.1,
              vertical: width * 0.08,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'capture',
                  backgroundColor: const Color(0xFF4CAF50),
                  onPressed: () =>
                      ref.read(scanNotifierProvider.notifier).takePicture(),
                  child: const Icon(Icons.camera_alt, color: Colors.white),
                ),
                if (state.capturedImages.isNotEmpty)
                  FloatingActionButton(
                    heroTag: 'process',
                    backgroundColor: Colors.orangeAccent,
                    onPressed: () => ref
                        .read(scanNotifierProvider.notifier)
                        .processImages(),
                    child: const Icon(Icons.check, color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

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
              final ingredientString = ingredients.join(', ');
              ref
                  .read(homeNotifierProvider.notifier)
                  .setMustIncludeIngredient(ingredientString);
              ref.read(scanNotifierProvider.notifier).resetDetection();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouter.home,
                (route) => false,
              );
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
