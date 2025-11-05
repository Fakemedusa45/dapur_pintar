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
      ),
    );
  }
}

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
    }

    return Stack(
      children: [
        CameraPreview(state.controller!),
        if (state.capturedImages.isNotEmpty) ...[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.capturedImages.length,
                itemBuilder: (context, index) {
                  return Padding(
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
        ],
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () => ref.read(scanNotifierProvider.notifier).takePicture(),
                  child: Icon(Icons.camera_alt),
                ),
                if (state.capturedImages.isNotEmpty)
                  FloatingActionButton(
                    onPressed: () => ref.read(scanNotifierProvider.notifier).processImages(),
                    child: Icon(Icons.check),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

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
          ),
        ],
      ),
    );
  }
}