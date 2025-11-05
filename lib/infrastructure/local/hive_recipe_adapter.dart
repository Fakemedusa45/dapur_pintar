// import 'package:hive/hive.dart';
// import 'package:dapur_pintar/domain/models/recipe.dart';

// part 'hive_recipe_adapter.g.dart';

// @HiveType(typeId: 0)
// class RecipeHiveModel extends HiveObject {
//   @HiveField(0)
//   String id;

//   @HiveField(1)
//   String title;

//   @HiveField(2)
//   String imageUrl;

//   @HiveField(3)
//   int duration;

//   @HiveField(4)
//   String difficulty;

//   @HiveField(5)
//   String category;

//   @HiveField(6)
//   List<String> ingredients;

//   @HiveField(7)
//   List<String> steps;

//   RecipeHiveModel({
//     required this.id,
//     required this.title,
//     required this.imageUrl,
//     required this.duration,
//     required this.difficulty,
//     required this.category,
//     required this.ingredients,
//     required this.steps,
//   });

//   /// Konversi dari HiveModel ke Domain Model
//   Recipe toDomain() => Recipe(
//         id: id,
//         title: title,
//         imageUrl: imageUrl,
//         duration: duration,
//         difficulty: difficulty,
//         category: category,
//         ingredients: ingredients,
//         steps: steps,
//       );

//   /// Konversi dari Domain Model ke HiveModel
//   static RecipeHiveModel fromDomain(Recipe recipe) => RecipeHiveModel(
//         id: recipe.id,
//         title: recipe.title,
//         imageUrl: recipe.imageUrl,
//         duration: recipe.duration,
//         difficulty: recipe.difficulty,
//         category: recipe.category,
//         ingredients: recipe.ingredients,
//         steps: recipe.steps,
//       );
// }
