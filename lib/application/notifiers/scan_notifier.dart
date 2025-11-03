import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';

// --- Definisi Kelas ScanState DIPERBAIKI ---
class ScanState {
  final List<CameraDescription> cameras;
  final CameraController? controller;
  final bool isProcessing;
  final List<String>? detectedIngredients;
  final String? error;
  // NEW: Add list to store multiple captured images
  final List<XFile> capturedImages;

  ScanState({
    this.cameras = const [],
    this.controller,
    this.isProcessing = false,
    this.detectedIngredients,
    this.error,
    this.capturedImages = const [], // Default to empty list
  });

  // Metode copyWith DITAMBAHKAN (updated to include capturedImages)
  ScanState copyWith({
    List<CameraDescription>? cameras,
    CameraController? controller,
    bool? isProcessing,
    List<String>? detectedIngredients,
    String? error,
    List<XFile>? capturedImages,
  }) {
    return ScanState(
      cameras: cameras ?? this.cameras,
      controller: controller ?? this.controller,
      isProcessing: isProcessing ?? this.isProcessing,
      detectedIngredients: detectedIngredients ?? this.detectedIngredients,
      error: error, // error bisa null, jadi langsung gunakan nilai baru atau null
      capturedImages: capturedImages ?? this.capturedImages,
    );
  }
}
// --- Akhir Definisi Kelas ScanState ---

// --- Kelas ScanNotifier DIPERBAIKI ---
class ScanNotifier extends StateNotifier<ScanState> {
  ScanNotifier() : super(ScanState()) {
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      final controller = CameraController(cameras.first, ResolutionPreset.medium);
      await controller.initialize();

      state = state.copyWith(cameras: cameras, controller: controller);
    } catch (e) {
      state = state.copyWith(error: e.toString()); // Gunakan copyWith
    }
  }

  // UPDATED: takePicture now adds to the capturedImages list instead of processing immediately
  Future<void> takePicture() async {
    if (state.controller == null) return;

    try {
      final image = await state.controller!.takePicture();
      // Add the captured image to the list
      final updatedImages = List<XFile>.from(state.capturedImages)..add(image);
      state = state.copyWith(capturedImages: updatedImages);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // NEW: Method to process all captured images (simulates AI analysis for all)
  Future<void> processImages() async {
    if (state.capturedImages.isEmpty) return;

    state = state.copyWith(isProcessing: true, error: null);

    try {
      // Simulate AI analysis for all images (replace with actual logic)
      await Future.delayed(Duration(seconds: 2));
      // For simplicity, use the same simulated ingredients for all images
      // In real implementation, process each image and combine results
      final simulatedIngredients = ['Ayam', 'Tomat', 'Bawang Putih', 'Kecap'];
      // If you want to merge from multiple detections, adjust here
      state = state.copyWith(
        isProcessing: false,
        detectedIngredients: simulatedIngredients,
        capturedImages: [], // Clear the list after processing
      );
    } catch (e) {
      state = state.copyWith(isProcessing: false, error: e.toString());
    }
  }

  // UPDATED: resetDetection now clears detectedIngredients and capturedImages
  void resetDetection() {
    state = state.copyWith(detectedIngredients: null, capturedImages: []);
  }

  void removeImage(int index) {
  if (index < 0 || index >= state.capturedImages.length) return;
  final updatedImages = List<XFile>.from(state.capturedImages)..removeAt(index);
  state = state.copyWith(capturedImages: updatedImages);
}
  @override
  void dispose() {
    state.controller?.dispose();
    super.dispose();
  }
}
// --- Akhir Kelas ScanNotifier ---