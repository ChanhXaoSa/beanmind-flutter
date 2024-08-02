// To parse this JSON data, do
//
//     final topicModel = topicModelFromJson(jsonString);

import 'dart:convert';

TopicModel topicModelFromJson(String str) => TopicModel.fromJson(json.decode(str));

String topicModelToJson(TopicModel data) => json.encode(data.toJson());

class TopicModel {
  String? message;
  bool? success;
  int? code;
  Data? data;
  dynamic errors;
  dynamic fieldErrors;

  TopicModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) => TopicModel(
    message: json["message"],
    success: json["success"],
    code: json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    errors: json["errors"],
    fieldErrors: json["fieldErrors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "code": code,
    "data": data?.toJson(),
    "errors": errors,
    "fieldErrors": fieldErrors,
  };
}

class Data {
  List<TopicItem>? items;
  int? pageIndex;
  int? pageSize;
  int? totalPage;

  Data({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: json["items"] == null ? [] : List<TopicItem>.from(json["items"]!.map((x) => TopicItem.fromJson(x))),
    pageIndex: json["pageIndex"],
    pageSize: json["pageSize"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "pageIndex": pageIndex,
    "pageSize": pageSize,
    "totalPage": totalPage,
  };
}

class Item {
  String? title;
  String? description;
  String? chapterId;
  String? id;
  bool? isDeleted;

  Item({
    this.title,
    this.description,
    this.chapterId,
    this.id,
    this.isDeleted,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    title: json["title"],
    description: json["description"],
    chapterId: json["chapterId"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "chapterId": chapterId,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class TopicItem {
  String? title;
  String? description;
  String? chapterId;
  String? id;
  bool? isDeleted;

  TopicItem({
    this.title,
    this.description,
    this.chapterId,
    this.id,
    this.isDeleted,
  });

  factory TopicItem.fromJson(Map<String, dynamic> json) => TopicItem(
    title: json["title"],
    description: json["description"],
    chapterId: json["chapterId"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "chapterId": chapterId,
    "id": id,
    "isDeleted": isDeleted,
  };
}
