import 'package:hive/hive.dart';

part 'recipe.g.dart';

@HiveType(typeId: 0)
class Recipe {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String imageUrl;
  @HiveField(3)
  final int duration; // dalam menit
  @HiveField(4)
  final String difficulty; // 'Mudah', 'Sedang', 'Sulit'
  @HiveField(5)
  final String category; // 'Sarapan', 'Makan Siang', dll
  @HiveField(6)
  final List<String> ingredients;
  @HiveField(7)
  final List<String> steps;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.difficulty,
    required this.category,
    required this.ingredients,
    required this.steps,
  });
}