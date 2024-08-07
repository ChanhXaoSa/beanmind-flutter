// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

CourseModel courseModelFromJson(String str) => CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  String? message;
  bool? success;
  int? code;
  Data? data;
  dynamic errors;
  dynamic fieldErrors;

  CourseModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
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
  List<Item>? items;
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
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
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
  String? imageURL;
  String? description;
  int? totalSlot;
  String? subjectId;
  String? programTypeId;
  String? courseLevelId;
  String? id;
  bool? isDeleted;

  Item({
    this.title,
    this.imageURL,
    this.description,
    this.totalSlot,
    this.subjectId,
    this.programTypeId,
    this.courseLevelId,
    this.id,
    this.isDeleted,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    title: json["title"],
    imageURL: json["imageURL"],
    description: json["description"],
    totalSlot: json["totalSlot"],
    subjectId: json["subjectId"],
    programTypeId: json["programTypeId"],
    courseLevelId: json["courseLevelId"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "imageURL": imageURL,
    "description": description,
    "totalSlot": totalSlot,
    "subjectId": subjectId,
    "programTypeId": programTypeId,
    "courseLevelId": courseLevelId,
    "id": id,
    "isDeleted": isDeleted,
  };
}
