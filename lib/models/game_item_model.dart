import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  final String id;
  String? imageurl;
  final int price;

  ItemModel({required this.id, this.imageurl, required this.price});

  factory ItemModel.fromString(String jsonString) =>
      ItemModel.fromJson(json.decode(jsonString));

  ItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        imageurl = json['imageurl'] as String?,
        price = json['price'] as int;

  ItemModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        imageurl = snapshot.data()?['imageurl'] as String?,
        price = snapshot.data()?['price'] as int;

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageurl': imageurl,
        'price': price,
      };
}

List<ItemModel> upperItemModel = [];
List<ItemModel> lowerItemModel = [];
List<ItemModel> startLowerItemModel = [];

int balance = 100;
int lastbalance = 20;
