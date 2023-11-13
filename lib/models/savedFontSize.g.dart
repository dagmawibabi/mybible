// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savedFontSize.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedFontSizeAdapter extends TypeAdapter<SavedFontSize> {
  @override
  final int typeId = 1;

  @override
  SavedFontSize read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedFontSize()
      ..eachVerseFontSize = fields[0] as double
      ..eachNumberFontSize = fields[1] as double
      ..eachCommentFontSize = fields[2] as double
      ..eachTopicFontSize = fields[3] as double;
  }

  @override
  void write(BinaryWriter writer, SavedFontSize obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.eachVerseFontSize)
      ..writeByte(1)
      ..write(obj.eachNumberFontSize)
      ..writeByte(2)
      ..write(obj.eachCommentFontSize)
      ..writeByte(3)
      ..write(obj.eachTopicFontSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedFontSizeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
