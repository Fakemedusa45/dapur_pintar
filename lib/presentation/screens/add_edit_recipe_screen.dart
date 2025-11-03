// lib/presentation/screens/add_edit_recipe_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';
import 'package:dapur_pintar/application/providers/home_provider.dart';
import 'package:go_router/go_router.dart';

class AddEditRecipeScreen extends ConsumerStatefulWidget {
  final Recipe? recipe; // Null jika mode 'Create', ada isinya jika mode 'Edit'

  const AddEditRecipeScreen({Key? key, this.recipe}) : super(key: key);

  @override
  ConsumerState<AddEditRecipeScreen> createState() => _AddEditRecipeScreenState();
}

class _AddEditRecipeScreenState extends ConsumerState<AddEditRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk setiap field
  late TextEditingController _titleController;
  late TextEditingController _imageUrlController;
  late TextEditingController _durationController;
  late TextEditingController _difficultyController;
  late TextEditingController _categoryController;
  late TextEditingController _ingredientsController;
  late TextEditingController _stepsController;

  bool get _isEditing => widget.recipe != null;

  @override
  void initState() {
    super.initState();
    // Isi controller dengan data resep jika ini adalah mode 'Edit'
    _titleController = TextEditingController(text: widget.recipe?.title ?? '');
    _imageUrlController = TextEditingController(text: widget.recipe?.imageUrl ?? '');
    _durationController = TextEditingController(text: widget.recipe?.duration.toString() ?? '');
    _difficultyController = TextEditingController(text: widget.recipe?.difficulty ?? 'Mudah');
    _categoryController = TextEditingController(text: widget.recipe?.category ?? 'Makan Malam');
    _ingredientsController = TextEditingController(text: widget.recipe?.ingredients.join(', ') ?? '');
    _stepsController = TextEditingController(text: widget.recipe?.steps.join('\n') ?? '');
  }

  @override
  void dispose() {
    // Jangan lupa dispose semua controller
    _titleController.dispose();
    _imageUrlController.dispose();
    _durationController.dispose();
    _difficultyController.dispose();
    _categoryController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    super.dispose();
  }

  void _submit() {
    // Validasi form
    if (_formKey.currentState!.validate()) {
      // Ubah input string menjadi tipe data yang benar
      final ingredients = _ingredientsController.text.split(',').map((e) => e.trim()).toList();
      final steps = _stepsController.text.split('\n').map((e) => e.trim()).toList();
      final duration = int.tryParse(_durationController.text) ?? 0;
      
      // Buat objek Recipe baru
      final newRecipe = Recipe(
        // Jika mode edit, gunakan ID lama. Jika mode create, buat ID baru (sederhana)
        id: widget.recipe?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        imageUrl: _imageUrlController.text,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Resep' : 'Tambah Resep'),
        actions: [
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
                _buildTextFormField(
                  controller: _imageUrlController,
                  label: 'URL Gambar',
                  validatorText: 'URL Gambar tidak boleh kosong',
                ),
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
          ),
        ),
      ),
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
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorText;
          }
          return null;
        },
      ),
    );
  }
}