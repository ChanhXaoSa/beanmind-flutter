// To parse this JSON data, do
//
//     final enrollmentModel = enrollmentModelFromJson(jsonString);

import 'dart:convert';

EnrollmentModel enrollmentModelFromJson(String str) => EnrollmentModel.fromJson(json.decode(str));

String enrollmentModelToJson(EnrollmentModel data) => json.encode(data.toJson());

class EnrollmentModel {
  String? message;
  bool? success;
  int? code;
  Data? data;
  dynamic errors;
  dynamic fieldErrors;

  EnrollmentModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) => EnrollmentModel(
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
  String? applicationUserId;
  String? courseId;
  bool? status;
  String? id;
  bool? isDeleted;

  Item({
    this.applicationUserId,
    this.courseId,
    this.status,
    this.id,
    this.isDeleted,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    applicationUserId: json["applicationUserId"],
    courseId: json["courseId"],
    status: json["status"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "applicationUserId": applicationUserId,
    "courseId": courseId,
    "status": status,
    "id": id,
    "isDeleted": isDeleted,
  };
}
