import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MemoryImageAdapter extends TypeAdapter<MemoryImage> {
  @override
  final typeId = 4;

  @override
  MemoryImage read(BinaryReader reader) {
    final micros = reader.readByteList();
    return MemoryImage(micros);
  }

  @override
  void write(BinaryWriter writer, MemoryImage obj) {
    writer.writeByteList(obj.bytes);
  }
}
