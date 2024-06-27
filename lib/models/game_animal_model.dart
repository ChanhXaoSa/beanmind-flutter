import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameAnimalModel {
  final String id;
  String? imageurl;
  final double VectorX;
  final double VectorY;
  final double scaleFactor;
  final int sprite;
  final double steptime;
  final String type;

  GameAnimalModel({
    required this.id,
    this.imageurl,
    required this.VectorX,
    required this.VectorY,
    required this.scaleFactor,
    required this.sprite,
    required this.steptime,
    required this.type,
  });

  factory GameAnimalModel.fromString(String jsonString) =>
      GameAnimalModel.fromJson(json.decode(jsonString));

  factory GameAnimalModel.fromJson(Map<String, dynamic> json) =>
      GameAnimalModel(
        id: json['id'] as String,
        imageurl: json['imageurl'] as String?,
        VectorX: json['VectorX'] as double,
        VectorY: json['VectorY'] as double,
        scaleFactor: json['scaleFactor'] as double,
        sprite: json['sprite'] as int,
        steptime: json['steptime'] as double,
        type: json['type'] as String,
      );

  factory GameAnimalModel.fromSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      GameAnimalModel(
        id: snapshot.id,
        imageurl: snapshot.data()?['imageurl'] as String?,
        VectorX: snapshot.data()?['VectorX'] as double,
        VectorY: snapshot.data()?['VectorY'] as double,
        scaleFactor: snapshot.data()?['scaleFactor'] as double,
        sprite: snapshot.data()?['sprite'] as int,
        steptime: snapshot.data()?['steptime'] as double,
        type: snapshot.data()?['type'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageurl': imageurl,
        'VectorX': VectorX,
        'VectorY': VectorY,
        'scaleFactor': scaleFactor,
        'sprite': sprite,
        'steptime': steptime,
        'type': type,
      };
}
