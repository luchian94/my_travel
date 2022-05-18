// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TravelAdapter extends TypeAdapter<Travel> {
  @override
  final int typeId = 1;

  @override
  Travel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Travel(
      id: fields[0] as String,
      country: fields[1] as Country,
      date: fields[2] as DateTime,
      img: fields[3] as MemoryImage,
      scale: fields[4] as double,
      previewScale: fields[5] as double,
      position: fields[6] as Offset,
      previewPosition: fields[7] as Offset,
    );
  }

  @override
  void write(BinaryWriter writer, Travel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.country)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.img)
      ..writeByte(4)
      ..write(obj.scale)
      ..writeByte(5)
      ..write(obj.previewScale)
      ..writeByte(6)
      ..write(obj.position)
      ..writeByte(7)
      ..write(obj.previewPosition);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TravelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
