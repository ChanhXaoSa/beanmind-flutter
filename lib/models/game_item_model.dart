import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  final String id;
  String? imageUrl;
  final int price;

  ItemModel({required this.id, this.imageUrl, required this.price});

  factory ItemModel.fromString(String jsonString) =>
      ItemModel.fromJson(json.decode(jsonString));

  ItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        imageUrl = json['images'] as String?,
        price = json['price'] as int;

  ItemModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        imageUrl = snapshot.data()?['images'] as String?,
        price = snapshot.data()?['price'] as int;

  Map<String, dynamic> toJson() => {
        'id': id,
        'images': imageUrl,
        'price': price,
      };
}

List<ItemModel> upper = [];
List<ItemModel> lower = [];
List<ItemModel> startLower = [];
