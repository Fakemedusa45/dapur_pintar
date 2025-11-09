<<<<<<< HEAD
// lib/presentation/screens/add_edit_recipe_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';
import 'package:dapur_pintar/application/providers/home_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';  // Tambahkan import ini
import 'dart:io';  // Untuk File

class AddEditRecipeScreen extends ConsumerStatefulWidget {
  final Recipe? recipe; // Null jika mode 'Create', ada isinya jika mode 'Edit'
=======
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';
import 'package:dapur_pintar/application/providers/home_provider.dart';

class AddEditRecipeScreen extends ConsumerStatefulWidget {
  final Recipe? recipe;
>>>>>>> e966c1c (UI DONE KAYANYA)

  const AddEditRecipeScreen({Key? key, this.recipe}) : super(key: key);

  @override
<<<<<<< HEAD
  ConsumerState<AddEditRecipeScreen> createState() => _AddEditRecipeScreenState();
=======
  ConsumerState<AddEditRecipeScreen> createState() =>
      _AddEditRecipeScreenState();
>>>>>>> e966c1c (UI DONE KAYANYA)
}

class _AddEditRecipeScreenState extends ConsumerState<AddEditRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

<<<<<<< HEAD
  // Controllers untuk setiap field
=======
>>>>>>> e966c1c (UI DONE KAYANYA)
  late TextEditingController _titleController;
  late TextEditingController _durationController;
  late TextEditingController _difficultyController;
  late TextEditingController _categoryController;
  late TextEditingController _ingredientsController;
  late TextEditingController _stepsController;

<<<<<<< HEAD
  // Untuk gambar: simpan path gambar yang dipilih
  String? _selectedImagePath;

  final ImagePicker _picker = ImagePicker();  // Instance ImagePicker
=======
  String? _selectedImagePath;
  final ImagePicker _picker = ImagePicker();
>>>>>>> e966c1c (UI DONE KAYANYA)

  bool get _isEditing => widget.recipe != null;

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    // Isi controller dengan data resep jika ini adalah mode 'Edit'
    _titleController = TextEditingController(text: widget.recipe?.title ?? '');
    _durationController = TextEditingController(text: widget.recipe?.duration.toString() ?? '');
    _difficultyController = TextEditingController(text: widget.recipe?.difficulty ?? 'Mudah');
    _categoryController = TextEditingController(text: widget.recipe?.category ?? 'Makan Malam');
    _ingredientsController = TextEditingController(text: widget.recipe?.ingredients.join(', ') ?? '');
    _stepsController = TextEditingController(text: widget.recipe?.steps.join('\n') ?? '');
    // Untuk gambar: jika edit, set path dari recipe
=======
    _titleController = TextEditingController(text: widget.recipe?.title ?? '');
    _durationController =
        TextEditingController(text: widget.recipe?.duration.toString() ?? '');
    // Set default difficulty to 'Mudah' if not editing or if recipe difficulty is not in list
    final difficulties = ['Mudah', 'Sedang', 'Sulit'];
    final recipeDifficulty = widget.recipe?.difficulty ?? 'Mudah';
    _difficultyController = TextEditingController(
      text: difficulties.contains(recipeDifficulty) ? recipeDifficulty : 'Mudah',
    );
    // Set default category to 'Makan Malam' if not editing or if recipe category is not in list
    final categories = ['Sarapan', 'Makan Siang', 'Makan Malam'];
    final recipeCategory = widget.recipe?.category ?? 'Makan Malam';
    _categoryController = TextEditingController(
      text: categories.contains(recipeCategory) ? recipeCategory : 'Makan Malam',
    );
    _ingredientsController = TextEditingController(
        text: widget.recipe?.ingredients.join(', ') ?? '');
    _stepsController =
        TextEditingController(text: widget.recipe?.steps.join('\n') ?? '');
>>>>>>> e966c1c (UI DONE KAYANYA)
    _selectedImagePath = widget.recipe?.imageUrl;
  }

  @override
  void dispose() {
<<<<<<< HEAD
    // Jangan lupa dispose semua controller
=======
>>>>>>> e966c1c (UI DONE KAYANYA)
    _titleController.dispose();
    _durationController.dispose();
    _difficultyController.dispose();
    _categoryController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    super.dispose();
  }

<<<<<<< HEAD
  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImageFromGallery() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    // Pindahkan ke direktori aplikasi agar path-nya permanen
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    final savedImage = await File(image.path).copy('${appDir.path}/$fileName');

    setState(() {
      _selectedImagePath = savedImage.path;
    });
  }
}

Future<void> _pickImageFromCamera() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  if (image != null) {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    final savedImage = await File(image.path).copy('${appDir.path}/$fileName');

    setState(() {
      _selectedImagePath = savedImage.path;
    });
  }
}
  // Fungsi untuk menghapus resep (hanya di mode edit)
  Future<void> _deleteRecipe() async {
    if (!_isEditing) return;

    // Tampilkan dialog konfirmasi
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Resep'),
        content: Text('Apakah Anda yakin ingin menghapus resep ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Hapus'),
=======
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1920,
      );
      
      if (image != null && mounted) {
        // Use the path directly from image picker
        // The path is already accessible and doesn't need to be copied
        if (mounted) {
          setState(() {
            _selectedImagePath = image.path;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memilih gambar: ${e.toString()}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _deleteRecipe() async {
    if (!_isEditing) return;
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Hapus Resep'),
        content: const Text('Apakah Anda yakin ingin menghapus resep ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Hapus'),
>>>>>>> e966c1c (UI DONE KAYANYA)
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
<<<<<<< HEAD
      // Panggil notifier untuk hapus
      final notifier = ref.read(homeNotifierProvider.notifier);
      notifier.deleteRecipe(widget.recipe!.id);
      // Kembali ke halaman sebelumnya
      context.pop();
=======
      final notifier = ref.read(homeNotifierProvider.notifier);
      notifier.deleteRecipe(widget.recipe!.id);
      // Wait for next frame to ensure state is updated before popping
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.pop();
        }
      });
>>>>>>> e966c1c (UI DONE KAYANYA)
    }
  }

  void _submit() {
<<<<<<< HEAD
    // Validasi form
    if (_formKey.currentState!.validate()) {
      // Pastikan gambar dipilih
      if (_selectedImagePath == null || _selectedImagePath!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pilih gambar terlebih dahulu')),
        );
        return;
      }

      // Ubah input string menjadi tipe data yang benar
      final ingredients = _ingredientsController.text.split(',').map((e) => e.trim()).toList();
      final steps = _stepsController.text.split('\n').map((e) => e.trim()).toList();
      final duration = int.tryParse(_durationController.text) ?? 0;
      
      // Buat objek Recipe baru
      final newRecipe = Recipe(
        // Jika mode edit, gunakan ID lama. Jika mode create, buat ID baru (sederhana)
        id: widget.recipe?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        imageUrl: _selectedImagePath!,  // Gunakan path gambar yang dipilih
        duration: duration,
        difficulty: _difficultyController.text,
        category: _categoryController.text,
        ingredients: ingredients,
        steps: steps,
      );

      // Panggil Notifier
      final notifier = ref.read(homeNotifierProvider.notifier);
      if (_isEditing) {
        notifier.updateRecipe(newRecipe);
      } else {
        notifier.addRecipe(newRecipe);
      }

      // Kembali ke halaman sebelumnya
      context.pop();
    }
=======
    if (!_formKey.currentState!.validate()) return;

    if (_selectedImagePath == null || _selectedImagePath!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih gambar terlebih dahulu')),
      );
      return;
    }

    final ingredients =
        _ingredientsController.text.split(',').map((e) => e.trim()).toList();
    final steps =
        _stepsController.text.split('\n').map((e) => e.trim()).toList();
    final duration = int.tryParse(_durationController.text) ?? 0;

    final newRecipe = Recipe(
      id: widget.recipe?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      imageUrl: _selectedImagePath!,
      duration: duration,
      difficulty: _difficultyController.text,
      category: _categoryController.text,
      ingredients: ingredients,
      steps: steps,
    );

    final notifier = ref.read(homeNotifierProvider.notifier);
    if (_isEditing) {
      notifier.updateRecipe(newRecipe);
    } else {
      notifier.addRecipe(newRecipe);
    }

    // Wait for next frame to ensure state is updated before popping
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.pop();
      }
    });
>>>>>>> e966c1c (UI DONE KAYANYA)
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Resep' : 'Tambah Resep'),
        actions: [
          if (_isEditing)  // Hanya tampilkan tombol hapus di mode edit
            IconButton(
              onPressed: _deleteRecipe,
              icon: Icon(Icons.delete),
              tooltip: 'Hapus Resep',
            ),
          IconButton(
            onPressed: _submit,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextFormField(
                  controller: _titleController,
                  label: 'Judul Resep',
                  validatorText: 'Judul tidak boleh kosong',
                ),
                // Ganti TextField dengan widget untuk memilih gambar
                _buildImagePickerWidget(),
                _buildTextFormField(
                  controller: _durationController,
                  label: 'Durasi (menit)',
                  validatorText: 'Durasi tidak boleh kosong',
                  keyboardType: TextInputType.number,
                ),
                _buildTextFormField(
                  controller: _difficultyController,
                  label: 'Tingkat Kesulitan (Mudah/Sedang/Sulit)',
                  validatorText: 'Tingkat Kesulitan tidak boleh kosong',
                ),
                _buildTextFormField(
                  controller: _categoryController,
                  label: 'Kategori (Sarapan/Makan Siang/dll)',
                  validatorText: 'Kategori tidak boleh kosong',
                ),
                _buildTextFormField(
                  controller: _ingredientsController,
                  label: 'Bahan (pisahkan dengan koma, cth: Ayam, Bawang)',
                  validatorText: 'Bahan tidak boleh kosong',
                  maxLines: 3,
                ),
                _buildTextFormField(
                  controller: _stepsController,
                  label: 'Langkah-langkah (pisahkan dengan baris baru/Enter)',
                  validatorText: 'Langkah-langkah tidak boleh kosong',
                  maxLines: 5,
                ),
              ],
            ),
=======
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Resep' : 'Tambah Resep',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        actions: [
          if (_isEditing)
            IconButton(
              tooltip: 'Hapus Resep',
              onPressed: _deleteRecipe,
              icon: const Icon(Icons.delete, color: Colors.white),
            ),
          IconButton(
            tooltip: 'Simpan Resep',
            onPressed: _submit,
            icon: const Icon(Icons.save, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextFormField(
                controller: _titleController,
                label: 'Judul Resep',
                validatorText: 'Judul tidak boleh kosong',
              ),
              const SizedBox(height: 12),
              _buildImagePickerWidget(width),
              _buildDurationField(),
              _buildDifficultyDropdown(),
              _buildCategoryDropdown(),
              _buildTextFormField(
                controller: _ingredientsController,
                label: 'Bahan (pisahkan dengan koma)',
                validatorText: 'Bahan tidak boleh kosong',
                maxLines: 3,
              ),
              _buildTextFormField(
                controller: _stepsController,
                label: 'Langkah-langkah (pisahkan baris baru)',
                validatorText: 'Langkah-langkah tidak boleh kosong',
                maxLines: 5,
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4CAF50).withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: FilledButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: Text(
                    _isEditing ? 'Simpan Perubahan' : 'Tambah Resep',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.1,
                      vertical: width * 0.045,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
>>>>>>> e966c1c (UI DONE KAYANYA)
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildImagePickerWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pilih Gambar',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          if (_selectedImagePath != null)
  Container(
    height: 150,
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: _selectedImagePath!.startsWith('assets/')
        ? Image.asset(
            _selectedImagePath!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
              );
            },
          )
        : Image.file(
            File(_selectedImagePath!),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
              );
            },
          ),
  ),

          SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _pickImageFromGallery,
                icon: Icon(Icons.photo_library),
                label: Text('Galeri'),
              ),
              SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: _pickImageFromCamera,
                icon: Icon(Icons.camera_alt),
                label: Text('Kamera'),
              ),
            ],
          ),
        ],
      ),
=======
  Widget _buildImagePickerWidget(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gambar Resep',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (_selectedImagePath != null && _selectedImagePath!.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF4CAF50).withOpacity(0.3),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _selectedImagePath!.startsWith('assets/')
                    ? Image.asset(
                        _selectedImagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, _, __) => _errorPlaceholder(),
                      )
                    : Image.file(
                        File(_selectedImagePath!),
                        fit: BoxFit.cover,
                        errorBuilder: (context, _, __) => _errorPlaceholder(),
                      ),
              ),
            ),
          )
        else
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_photo_alternate,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 12),
                Text(
                  'Pilih gambar resep',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.3)),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4CAF50).withOpacity(0.05),
                      Colors.white,
                    ],
                  ),
                ),
                child: OutlinedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library, color: Color(0xFF4CAF50)),
                  label: const Text(
                    'Galeri',
                    style: TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: width * 0.035),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.3)),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4CAF50).withOpacity(0.05),
                      Colors.white,
                    ],
                  ),
                ),
                child: OutlinedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt, color: Color(0xFF4CAF50)),
                  label: const Text(
                    'Kamera',
                    style: TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: width * 0.035),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
>>>>>>> e966c1c (UI DONE KAYANYA)
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String validatorText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
<<<<<<< HEAD
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorText;
=======
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        style: const TextStyle(fontSize: 15),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) =>
            value == null || value.isEmpty ? validatorText : null,
      ),
    );
  }

  Widget _buildDurationField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _durationController,
        decoration: InputDecoration(
          labelText: 'Durasi (menit)',
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          prefixIcon: const Icon(Icons.access_time, color: Color(0xFF4CAF50)),
        ),
        style: const TextStyle(fontSize: 15),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Durasi tidak boleh kosong';
          }
          final duration = int.tryParse(value);
          if (duration == null || duration <= 0) {
            return 'Durasi harus berupa angka positif';
>>>>>>> e966c1c (UI DONE KAYANYA)
          }
          return null;
        },
      ),
    );
  }
<<<<<<< HEAD
}
=======

  Widget _buildDifficultyDropdown() {
    final difficulties = ['Mudah', 'Sedang', 'Sulit'];
    final currentValue = _difficultyController.text.isEmpty 
        ? null 
        : (difficulties.contains(_difficultyController.text) ? _difficultyController.text : null);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: currentValue,
        decoration: InputDecoration(
          labelText: 'Tingkat Kesulitan',
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          prefixIcon: const Icon(Icons.flag, color: Color(0xFF4CAF50)),
        ),
        items: difficulties.map((String difficulty) {
          Color? chipColor;
          IconData icon;
          switch (difficulty) {
            case 'Mudah':
              chipColor = Colors.green;
              icon = Icons.sentiment_satisfied;
              break;
            case 'Sedang':
              chipColor = Colors.orange;
              icon = Icons.sentiment_neutral;
              break;
            case 'Sulit':
              chipColor = Colors.red;
              icon = Icons.sentiment_very_dissatisfied;
              break;
            default:
              chipColor = Colors.grey;
              icon = Icons.flag;
          }
          return DropdownMenuItem<String>(
            value: difficulty,
            child: Row(
              children: [
                Icon(icon, color: chipColor, size: 20),
                const SizedBox(width: 12),
                Text(
                  difficulty,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          if (value != null) {
            setState(() {
              _difficultyController.text = value;
            });
          }
        },
        validator: (value) =>
            value == null || value.isEmpty ? 'Tingkat Kesulitan tidak boleh kosong' : null,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(16),
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF4CAF50)),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    final categories = ['Sarapan', 'Makan Siang', 'Makan Malam'];
    final currentValue = _categoryController.text.isEmpty 
        ? null 
        : (categories.contains(_categoryController.text) ? _categoryController.text : null);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: currentValue,
        decoration: InputDecoration(
          labelText: 'Kategori',
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          prefixIcon: const Icon(Icons.category, color: Color(0xFF4CAF50)),
        ),
        items: categories.map((String category) {
          Color? chipColor;
          IconData icon;
          switch (category) {
            case 'Sarapan':
              chipColor = Colors.amber;
              icon = Icons.wb_sunny;
              break;
            case 'Makan Siang':
              chipColor = Colors.orange;
              icon = Icons.lunch_dining;
              break;
            case 'Makan Malam':
              chipColor = Colors.deepPurple;
              icon = Icons.dinner_dining;
              break;
            default:
              chipColor = Colors.grey;
              icon = Icons.category;
          }
          return DropdownMenuItem<String>(
            value: category,
            child: Row(
              children: [
                Icon(icon, color: chipColor, size: 20),
                const SizedBox(width: 12),
                Text(
                  category,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          if (value != null) {
            setState(() {
              _categoryController.text = value;
            });
          }
        },
        validator: (value) =>
            value == null || value.isEmpty ? 'Kategori tidak boleh kosong' : null,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(16),
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF4CAF50)),
      ),
    );
  }

  Widget _errorPlaceholder() => Center(
        child: Icon(Icons.broken_image, size: 50, color: Colors.grey[400]),
      );
}
>>>>>>> e966c1c (UI DONE KAYANYA)
