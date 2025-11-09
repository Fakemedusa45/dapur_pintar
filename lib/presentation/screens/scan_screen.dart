<<<<<<< HEAD
import 'dart:io';  // Add this import for File
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';  // Added for GoRouter navigation
// Import provider
import 'package:dapur_pintar/application/providers/scan_provider.dart'; // <- Untuk scanNotifierProvider
// Tambahkan import untuk ScanState
import 'package:dapur_pintar/application/notifiers/scan_notifier.dart'; // <- Import ini DIBUTUHKAN untuk ScanState
import 'package:dapur_pintar/application/providers/home_provider.dart'; // <- Untuk navigasi ke home setelah scan
import 'package:dapur_pintar/presentation/routes/app_router.dart';  // For AppRouter constants
import 'package:dapur_pintar/presentation/screens/home_screen.dart';  // For HomeContent
import 'package:dapur_pintar/presentation/screens/saved_recipes_screen.dart'; // For _SavedContent

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  int _selectedIndex = 2;  // Default to "Scan" tab (index 2)

  static final List<Widget> _screens = <Widget>[
    HomeContent(),      // Home content (recipes)
    SavedContent(),    // Saved recipes content
    _ScanContent(),     // Scan content (extracted from original body)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Use GoRouter to navigate (replace current route)
=======
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:dapur_pintar/application/providers/scan_provider.dart';
import 'package:dapur_pintar/application/notifiers/scan_notifier.dart';
import 'package:dapur_pintar/application/providers/home_provider.dart';
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
    const HomeContent(),
    const SavedContent(),
    const _ScanContent(),
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
        title: Text('Pindai Bahan'),  // Kept your original app bar title
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
=======
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
>>>>>>> e966c1c (UI DONE KAYANYA)
      ),
    );
  }
}

<<<<<<< HEAD
// Extracted widget for scan content (keeps your original logic clean)
class _ScanContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scanNotifierProvider);

    return state.error != null
        ? Center(child: Text('Error: ${state.error}'))
        : state.isProcessing
            ? Center(child: CircularProgressIndicator())
            : state.detectedIngredients != null
                ? _buildResults(context, ref, state.detectedIngredients!)
                : _buildCaptureView(ref, state);
  }

  Widget _buildCaptureView(WidgetRef ref, ScanState state) {
    if (state.controller == null || !state.controller!.value.isInitialized) {
      return Container();
=======
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
>>>>>>> e966c1c (UI DONE KAYANYA)
    }

    return Stack(
      children: [
<<<<<<< HEAD
        CameraPreview(state.controller!),
        if (state.capturedImages.isNotEmpty) ...[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 100,
=======
        Positioned.fill(child: CameraPreview(state.controller!)),

        // Preview of captured images
        if (state.capturedImages.isNotEmpty)
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: width * 0.25,
              margin: const EdgeInsets.only(top: 16),
>>>>>>> e966c1c (UI DONE KAYANYA)
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.capturedImages.length,
                itemBuilder: (context, index) {
                  return Padding(
<<<<<<< HEAD
                    padding: EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Image.file(
                          File(state.capturedImages[index].path),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => ref.read(scanNotifierProvider.notifier).removeImage(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
=======
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
>>>>>>> e966c1c (UI DONE KAYANYA)
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
<<<<<<< HEAD
        ],
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(24.0),
=======

        // Bottom Action Buttons
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
>>>>>>> e966c1c (UI DONE KAYANYA)
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
<<<<<<< HEAD
                  onPressed: () => ref.read(scanNotifierProvider.notifier).takePicture(),
                  child: Icon(Icons.camera_alt),
                ),
                if (state.capturedImages.isNotEmpty)
                  FloatingActionButton(
                    onPressed: () => ref.read(scanNotifierProvider.notifier).processImages(),
                    child: Icon(Icons.check),
=======
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
>>>>>>> e966c1c (UI DONE KAYANYA)
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

<<<<<<< HEAD
  Widget _buildResults(BuildContext context, WidgetRef ref, List<String> ingredients) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, size: 64, color: Colors.green),
          SizedBox(height: 16),
          Text(
            'Bahan Terdeteksi:',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: ingredients.map((ing) => Chip(label: Text(ing))).toList(),
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              
              final ingredientString = ingredients.join(', ');
              ref.read(homeNotifierProvider.notifier).setMustIncludeIngredient(ingredientString);
              ref.read(scanNotifierProvider.notifier).resetDetection(); 
              Navigator.pushNamedAndRemoveUntil(context, AppRouter.home, (route) => false);
            },
            child: Text('Cari Resep Berdasarkan Bahan Ini'),
=======
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
                  context, AppRouter.home, (route) => false);
            },
            icon: const Icon(Icons.search, color: Colors.white),
            label: const Text(
              'Cari Resep Berdasarkan Bahan Ini',
              style: TextStyle(color: Colors.white),
            ),
>>>>>>> e966c1c (UI DONE KAYANYA)
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
