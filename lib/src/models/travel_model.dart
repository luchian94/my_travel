import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'country_model.dart';

part 'travel_model.g.dart';

@HiveType(typeId: 1)
class Travel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  Country country;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  MemoryImage img;

  @HiveField(4)
  double scale;

  @HiveField(5)
  double previewScale;

  @HiveField(6)
  Offset position;

  @HiveField(7)
  Offset previewPosition;

  Travel({
    this.id,
    this.country,
    this.date,
    this.img,
    this.scale,
    this.previewScale,
    this.position,
    this.previewPosition,
  });

  /*factory Travel.fromJson(Map<String, dynamic> json) {
    List<String> positionVal =
        json['position'] != null ? (json['position'] as String).split('#') : [];
    double positionDx =
        positionVal.length > 0 ? double.parse(positionVal[0]) : 0.0;
    double positionDy =
        positionVal.length > 0 ? double.parse(positionVal[1]) : 0.0;

    List<String> previewPositionVal = json['previewPosition'] != null
        ? (json['previewPosition'] as String).split('#')
        : [];
    double previewPositionDx = previewPositionVal.length > 0
        ? double.parse(previewPositionVal[0])
        : 0.0;
    double previewPositionDy = previewPositionVal.length > 0
        ? double.parse(previewPositionVal[1])
        : 0.0;

    return Travel(
      id: json['id'] as String,
      country: json['country'] != null ? Country.fromJson(json['country']) : null,
      date: DateFormat("yyyy-MM-dd").parse(json['date']),
      img: MemoryImage(base64Decode(json['img'])),
      scale: json['scale'] as double,
      previewScale: json['previewScale'] as double,
      position: Offset(positionDx, positionDy),
      previewPosition: Offset(previewPositionDx, previewPositionDy),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'country': country,
        'date': DateFormat('yyyy-MM-dd').format(date),
        'img': base64Encode(img.bytes),
        'scale': scale,
        'previewScale': previewScale,
        'position': position != null
            ? position.dx.toString() + '#' + position.dy.toString()
            : '',
        'previewPosition': previewPosition != null
            ? previewPosition.dx.toString() +
                '#' +
                previewPosition.dy.toString()
            : '',
      };*/
}
