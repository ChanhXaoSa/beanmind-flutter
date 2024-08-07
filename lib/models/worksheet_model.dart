// To parse this JSON data, do
//
//     final worksheetModel = worksheetModelFromJson(jsonString);

import 'dart:convert';

WorksheetModel worksheetModelFromJson(String str) => WorksheetModel.fromJson(json.decode(str));

String worksheetModelToJson(WorksheetModel data) => json.encode(data.toJson());

class WorksheetModel {
  String? message;
  bool? success;
  int? code;
  WorksheetData? data;
  dynamic errors;
  dynamic fieldErrors;

  WorksheetModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory WorksheetModel.fromJson(Map<String, dynamic> json) => WorksheetModel(
    message: json["message"],
    success: json["success"],
    code: json["code"],
    data: json["data"] == null ? null : WorksheetData.fromJson(json["data"]),
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

class WorksheetData {
  List<WorksheetItem>? items;
  int? pageIndex;
  int? pageSize;
  int? totalPage;

  WorksheetData({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalPage,
  });

  factory WorksheetData.fromJson(Map<String, dynamic> json) => WorksheetData(
    items: json["items"] == null ? [] : List<WorksheetItem>.from(json["items"]!.map((x) => WorksheetItem.fromJson(x))),
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

class WorksheetItem {
  String? title;
  String? description;
  String? worksheetTemplateId;
  String? id;
  bool? isDeleted;

  WorksheetItem({
    this.title,
    this.description,
    this.worksheetTemplateId,
    this.id,
    this.isDeleted,
  });

  factory WorksheetItem.fromJson(Map<String, dynamic> json) => WorksheetItem(
    title: json["title"],
    description: json["description"],
    worksheetTemplateId: json["worksheetTemplateId"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "worksheetTemplateId": worksheetTemplateId,
    "id": id,
    "isDeleted": isDeleted,
  };
}
