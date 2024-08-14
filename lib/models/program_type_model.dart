// To parse this JSON data, do
//
//     final programTypeModel = programTypeModelFromJson(jsonString);

import 'dart:convert';

ProgramTypeModel programTypeModelFromJson(String str) => ProgramTypeModel.fromJson(json.decode(str));

String programTypeModelToJson(ProgramTypeModel data) => json.encode(data.toJson());

class ProgramTypeModel {
  String? message;
  bool? success;
  int? code;
  Data? data;
  dynamic errors;
  dynamic fieldErrors;

  ProgramTypeModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory ProgramTypeModel.fromJson(Map<String, dynamic> json) => ProgramTypeModel(
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
  List<ProgramTypeModelItem>? items;
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
    items: json["items"] == null ? [] : List<ProgramTypeModelItem>.from(json["items"]!.map((x) => ProgramTypeModelItem.fromJson(x))),
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

class ProgramTypeModelItem {
  String? title;
  String? description;
  List<dynamic>? courses;
  String? id;
  bool? isDeleted;

  ProgramTypeModelItem({
    this.title,
    this.description,
    this.courses,
    this.id,
    this.isDeleted,
  });

  factory ProgramTypeModelItem.fromJson(Map<String, dynamic> json) => ProgramTypeModelItem(
    title: json["title"],
    description: json["description"],
    courses: json["courses"] == null ? [] : List<dynamic>.from(json["courses"]!.map((x) => x)),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x)),
    "id": id,
    "isDeleted": isDeleted,
  };
}
