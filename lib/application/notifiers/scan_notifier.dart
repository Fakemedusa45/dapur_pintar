import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// HAPUS import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart'; // <-- TAMBAHKAN

// --- Definisi Kelas ScanState (Modifikasi) ---
class ScanState {
  // HAPUS final List<CameraDescription> cameras;
  // HAPUS final CameraController? controller;
  final bool isProcessing;
  final List<String>? detectedIngredients;
  final String? error;
  final List<XFile> capturedImages;

  ScanState({
    // HAPUS this.cameras = const [],
    // HAPUS this.controller,
    this.isProcessing = false,
    this.detectedIngredients,
    this.error,
    this.capturedImages = const [],
  });

  ScanState copyWith({
    // HAPUS List<CameraDescription>? cameras,
    // HAPUS CameraController? controller,
    bool? isProcessing,
    List<String>? detectedIngredients,
    String? error,
    List<XFile>? capturedImages,
  }) {
    return ScanState(
      // HAPUS cameras: cameras ?? this.cameras,
      // HAPUS controller: controller ?? this.controller,
      isProcessing: isProcessing ?? this.isProcessing,
      detectedIngredients: detectedIngredients ?? this.detectedIngredients,
      error: error,
      capturedImages: capturedImages ?? this.capturedImages,
    );
  }
}
// --- Akhir Definisi Kelas ScanState ---

// --- Kelas ScanNotifier ---
class ScanNotifier extends StateNotifier<ScanState> {
  // HAPUS constructor
  ScanNotifier() : super(ScanState());
  // HAPUS inisialisasi kamera

  // TAMBAHKAN ImagePicker
  final ImagePicker _picker = ImagePicker();

  static const String BASE_URL =
      'https://GalaxionZero-raw-indonesian-food-detection.hf.space';

  // HAPUS initializeCamera()
  // HAPUS takePicture()

  // TAMBAHKAN pickImage (Mirip Add/Edit Screen)
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1920,
      );

      if (image != null) {
        // Ini bedanya: kita MENAMBAHKAN ke list, bukan mengganti
        final updatedImages = List<XFile>.from(state.capturedImages)..add(image);
        state = state.copyWith(capturedImages: updatedImages);
      }
    } catch (e) {
      state = state.copyWith(error: 'Gagal memilih gambar: ${e.toString()}');
    }
  }
  // --- AKHIR FUNGSI pickImage ---

  // Process a single image and return the top prediction
  Future<String?> _classifySingleImage(File imageFile) async {
    try {
      // Read and encode image
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      // Step 1: Call the predict endpoint
      var callUrl = Uri.parse('$BASE_URL/gradio_api/call/predict');
      var requestBody = json.encode({
        "data": [
          {
            "path": "data:image/jpeg;base64,$base64Image",
            "url": "data:image/jpeg;base64,$base64Image",
            "size": imageBytes.length,
            "orig_name": "image.jpg",
            "mime_type": "image/jpeg"
          }
        ]
      });

      var callResponse = await http.post(
        callUrl,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      ).timeout(Duration(seconds: 30));

      if (callResponse.statusCode != 200) {
        throw Exception('Call failed: ${callResponse.statusCode}');
      }

      var callResult = json.decode(callResponse.body);
      String eventId = callResult['event_id'];

      // Step 2: Stream the result
      var resultUrl = Uri.parse('$BASE_URL/gradio_api/call/predict/$eventId');
      var request = http.Request('GET', resultUrl);
      var streamedResponse = await request.send().timeout(Duration(seconds: 60));

      if (streamedResponse.statusCode != 200) {
        throw Exception('Stream failed: ${streamedResponse.statusCode}');
      }

      // Step 3: Read stream and extract top prediction
      await for (var chunk in streamedResponse.stream.transform(utf8.decoder)) {
        var lines = chunk.split('\n');
        for (var line in lines) {
          if (!line.startsWith('data: ') || line.length < 10) continue;

          var jsonStr = line.substring(6).trim();
          if (jsonStr.isEmpty) continue;

          try {
            var data = json.decode(jsonStr);

            if (data is List && data.isNotEmpty) {
              var firstItem = data[0];

              if (firstItem is Map && firstItem.containsKey('confidences')) {
                var confidences = firstItem['confidences'] as List;

                // Find the highest confidence prediction
                double maxConfidence = 0.0;
                String topLabel = '';

                for (var item in confidences) {
                  double confidence = (item['confidence'] as num).toDouble();
                  if (confidence > maxConfidence) {
                    maxConfidence = confidence;
                    topLabel = item['label'];
                  }
                }

                return topLabel; // Return the top prediction
              }
            }
          } catch (e) {
            continue;
          }
        }
      }

      throw Exception('No result found in stream');
    } catch (e) {
      print('❌ Classification error: $e');
      return null;
    }
  }

  // Process all captured images
  Future<void> processImages() async {
    if (state.capturedImages.isEmpty) return;

    state = state.copyWith(isProcessing: true, error: null);

    try {
      List<String> detectedIngredients = [];

      // Process each image sequentially
      for (var xfile in state.capturedImages) {
        final imageFile = File(xfile.path);
        final prediction = await _classifySingleImage(imageFile);

        if (prediction != null && prediction.isNotEmpty) {
          detectedIngredients.add(prediction);
        }
      }

      if (detectedIngredients.isEmpty) {
        throw Exception('No ingredients detected');
      }

      // Remove duplicates
      detectedIngredients = detectedIngredients.toSet().toList();

      state = state.copyWith(
        isProcessing: false,
        detectedIngredients: detectedIngredients,
        capturedImages: [], // Clear the list after processing
      );
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        error: 'Failed to process images: $e',
      );
    }
  }

  void resetDetection() {
    state = state.copyWith(detectedIngredients: null, capturedImages: []);
  }

  void removeImage(int index) {
    if (index < 0 || index >= state.capturedImages.length) return;
    final updatedImages = List<XFile>.from(state.capturedImages)
      ..removeAt(index);
    state = state.copyWith(capturedImages: updatedImages);
  }

  @override
  void dispose() {
    // HAPUS controller.dispose()
    super.dispose();
  }
}
// --- Akhir Kelas ScanNotifier ---