import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class OffsetAdapter extends TypeAdapter<Offset> {
  @override
  final typeId = 5;

  @override
  Offset read(BinaryReader reader) {
    List<double> micros = reader.readDoubleList();
    return Offset(micros[0], micros[1]);
  }

  @override
  void write(BinaryWriter writer, Offset obj) {
    writer.writeDoubleList([obj.dx, obj.dy]);
  }
}
