// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClothingAdapter extends TypeAdapter<Clothing> {
  @override
  final int typeId = 0;

  @override
  Clothing read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Clothing(
      id: fields[0] as int,
      category: fields[1] as ClothingCategory,
      subCategory: fields[2] as ClothingCategory,
      brand: fields[3] as Brand,
      size: fields[4] as String,
      imageUrl: fields[5] as String,
      url: fields[6] as String,
      price: fields[7] as int,
      seasons: (fields[8] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Clothing obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.subCategory)
      ..writeByte(3)
      ..write(obj.brand)
      ..writeByte(4)
      ..write(obj.size)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.url)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.seasons);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClothingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SetAdapter extends TypeAdapter<Set> {
  @override
  final int typeId = 1;

  @override
  Set read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Set(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      imageUrl: fields[3] as String,
      minTemp: fields[4] as int,
      maxTemp: fields[5] as int,
      clothes: (fields[6] as List)?.cast<Clothing>(),
      cases: (fields[7] as List)?.cast<Case>(),
      seasons: (fields[8] as List)?.cast<Season>(),
    );
  }

  @override
  void write(BinaryWriter writer, Set obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.minTemp)
      ..writeByte(5)
      ..write(obj.maxTemp)
      ..writeByte(6)
      ..write(obj.clothes)
      ..writeByte(7)
      ..write(obj.cases)
      ..writeByte(8)
      ..write(obj.seasons);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ClothingCategoryAdapter extends TypeAdapter<ClothingCategory> {
  @override
  final int typeId = 2;

  @override
  ClothingCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClothingCategory(
      name: fields[0] as String,
      url: fields[1] as String,
      tags: (fields[2] as List)?.cast<String>(),
      subcategory: (fields[3] as List)?.cast<ClothingCategory>(),
    );
  }

  @override
  void write(BinaryWriter writer, ClothingCategory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.tags)
      ..writeByte(3)
      ..write(obj.subcategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClothingCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BrandAdapter extends TypeAdapter<Brand> {
  @override
  final int typeId = 3;

  @override
  Brand read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Brand(
      name: fields[0] as String,
      url: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Brand obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrandAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
