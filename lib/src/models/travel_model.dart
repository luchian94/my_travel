import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'country_model.dart';

class Travel {
  final String id;
  Country country;
  DateTime date;
  MemoryImage img;
  double scale;
  double previewScale;
  Offset position;
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

  factory Travel.fromJson(Map<String, dynamic> json) {
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
      };
}
