// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_recipe_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapterAdapter extends TypeAdapter<RecipeAdapter> {
  @override
  final int typeId = 0;

  @override
  RecipeAdapter read(BinaryReader reader) {
    return RecipeAdapter();
  }

  @override
  void write(BinaryWriter writer, RecipeAdapter obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
