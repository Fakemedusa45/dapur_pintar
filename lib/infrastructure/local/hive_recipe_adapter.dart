// lib/infrastructure/local/hive_recipe_adapter.dart
// Dijalankan setelah membuat model Recipe
// Jalankan: flutter packages pub run build_runner build
import 'package:hive/hive.dart';
import 'package:dapur_pintar/domain/models/recipe.dart';

part 'hive_recipe_adapter.g.dart';

@HiveType(typeId: 0)
class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 0;

  @override
  Recipe read(BinaryReader reader) {
    return Recipe(
      id: reader.readString(),
      title: reader.readString(),
      imageUrl: reader.readString(),
      duration: reader.readInt(),
      difficulty: reader.readString(),
      category: reader.readString(),
      ingredients: reader.readStringList(),
      steps: reader.readStringList(),
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.imageUrl);
    writer.writeInt(obj.duration);
    writer.writeString(obj.difficulty);
    writer.writeString(obj.category);
    writer.writeStringList(obj.ingredients);
    writer.writeStringList(obj.steps);
  }
}