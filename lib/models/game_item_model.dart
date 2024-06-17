import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ItemModel {
  final String id;
  String? imageUrl;
  final int price;

  ItemModel({required this.id, this.imageUrl, required this.price});

  factory ItemModel.fromString(String jsonString) =>
      ItemModel.fromJson(json.decode(jsonString));

  ItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        imageUrl = json['images'] as String,
        price = json['price'] as int;

  ItemModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        imageUrl = snapshot['images'],
        price = snapshot['price'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'images': imageUrl,
        'price': price,
      };
}
