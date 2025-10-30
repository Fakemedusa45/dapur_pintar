import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
// Import provider
import 'package:dapur_pintar/application/providers/scan_provider.dart'; // <- Untuk scanNotifierProvider
// Tambahkan import untuk ScanState
import 'package:dapur_pintar/application/notifiers/scan_notifier.dart'; // <- Import ini DIBUTUHKAN untuk ScanState
import 'package:dapur_pintar/application/providers/home_provider.dart'; // <- Untuk navigasi ke home setelah scan
import 'package:dapur_pintar/presentation/routes/app_router.dart';

class ScanScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scanNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pindai Bahan'),
      ),
      body: state.error != null
          ? Center(child: Text('Error: ${state.error}'))
          : state.isProcessing
              ? Center(child: CircularProgressIndicator())
              : state.detectedIngredients != null
                  ? _buildResults(context, ref, state.detectedIngredients!)
                  : _buildCameraView(ref, state),
    );
  }

  Widget _buildCameraView(WidgetRef ref, ScanState state) {
    if (state.controller == null || !state.controller!.value.isInitialized) {
      return Container();
    }

    return Stack(
      children: [
        CameraPreview(state.controller!),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: FloatingActionButton(
              onPressed: () => ref.read(scanNotifierProvider.notifier).takePicture(),
              child: Icon(Icons.camera_alt),
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
              // Set filter di home provider
              final ingredientString = ingredients.join(', ');
              ref.read(homeNotifierProvider.notifier).setMustIncludeIngredient(ingredientString);
              ref.read(scanNotifierProvider.notifier).resetDetection(); // Reset state scan
              // Navigate ke home screen
              Navigator.pushNamedAndRemoveUntil(context, AppRouter.home, (route) => false);
            },
            child: Text('Cari Resep Berdasarkan Bahan Ini'),
          ),
        ],
      ),
    );
  }
}