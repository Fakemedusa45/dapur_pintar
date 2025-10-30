import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';

// --- Definisi Kelas ScanState DIPERBAIKI ---
class ScanState {
  final List<CameraDescription> cameras;
  final CameraController? controller;
  final bool isProcessing;
  final List<String>? detectedIngredients;
  final String? error;

  ScanState({
    this.cameras = const [],
    this.controller,
    this.isProcessing = false,
    this.detectedIngredients,
    this.error,
  });

  // Metode copyWith DITAMBAHKAN
  ScanState copyWith({
    List<CameraDescription>? cameras,
    CameraController? controller,
    bool? isProcessing,
    List<String>? detectedIngredients,
    String? error,
  }) {
    return ScanState(
      cameras: cameras ?? this.cameras,
      controller: controller ?? this.controller,
      isProcessing: isProcessing ?? this.isProcessing,
      detectedIngredients: detectedIngredients ?? this.detectedIngredients,
      error: error, // error bisa null, jadi langsung gunakan nilai baru atau null
    );
  }
}
// --- Akhir Definisi Kelas ScanState ---

// --- Kelas ScanNotifier Tetap Sama ---
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

  Future<void> takePicture() async {
    if (state.controller == null) return;

    state = state.copyWith(isProcessing: true, error: null); // Gunakan copyWith

    try {
      await state.controller!.takePicture();
      // Simulasikan AI analysis
      await Future.delayed(Duration(seconds: 2));
      final simulatedIngredients = ['Ayam', 'Tomat', 'Bawang Putih', 'Kecap'];
      state = state.copyWith(
        isProcessing: false,
        detectedIngredients: simulatedIngredients,
      ); // Gunakan copyWith
    } catch (e) {
      state = state.copyWith(isProcessing: false, error: e.toString()); // Gunakan copyWith
    }
  }

  void resetDetection() {
    state = state.copyWith(detectedIngredients: null); // Gunakan copyWith
  }

  @override
  void dispose() {
    state.controller?.dispose();
    super.dispose();
  }
}
// --- Akhir Kelas ScanNotifier ---