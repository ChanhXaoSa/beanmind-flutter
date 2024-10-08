// To parse this JSON data, do
//
//     final courseLevelModel = courseLevelModelFromJson(jsonString);

import 'dart:convert';

CourseLevelModel courseLevelModelFromJson(String str) => CourseLevelModel.fromJson(json.decode(str));

String courseLevelModelToJson(CourseLevelModel data) => json.encode(data.toJson());

class CourseLevelModel {
  String? message;
  bool? success;
  int? code;
  Data? data;
  dynamic errors;
  dynamic fieldErrors;

  CourseLevelModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory CourseLevelModel.fromJson(Map<String, dynamic> json) => CourseLevelModel(
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
  List<CourseLevelModelItem>? items;
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
    items: json["items"] == null ? [] : List<CourseLevelModelItem>.from(json["items"]!.map((x) => CourseLevelModelItem.fromJson(x))),
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

class CourseLevelModelItem {
  String? title;
  String? description;
  String? id;
  bool? isDeleted;

  CourseLevelModelItem({
    this.title,
    this.description,
    this.id,
    this.isDeleted,
  });

  factory CourseLevelModelItem.fromJson(Map<String, dynamic> json) => CourseLevelModelItem(
    title: json["title"],
    description: json["description"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "id": id,
    "isDeleted": isDeleted,
  };
}
