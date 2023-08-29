// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savedVerses.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedVerseAdapter extends TypeAdapter<SavedVerse> {
  @override
  final int typeId = 0;

  @override
  SavedVerse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedVerse()
      ..version = fields[0] as String
      ..testament = fields[1] as String
      ..book = fields[2] as String
      ..chapter = fields[3] as int
      ..number = fields[4] as int
      ..verse = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, SavedVerse obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.version)
      ..writeByte(1)
      ..write(obj.testament)
      ..writeByte(2)
      ..write(obj.book)
      ..writeByte(3)
      ..write(obj.chapter)
      ..writeByte(4)
      ..write(obj.number)
      ..writeByte(5)
      ..write(obj.verse);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedVerseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
