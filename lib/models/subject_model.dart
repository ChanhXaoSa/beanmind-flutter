// To parse this JSON data, do
//
//     final subjectModel = subjectModelFromJson(jsonString);

import 'dart:convert';

SubjectModel subjectModelFromJson(String str) => SubjectModel.fromJson(json.decode(str));

String subjectModelToJson(SubjectModel data) => json.encode(data.toJson());

class SubjectModel {
  String? message;
  bool? success;
  int? code;
  Data? data;
  dynamic errors;
  dynamic fieldErrors;

  SubjectModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
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
  List<SubjectModelItem>? items;
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
    items: json["items"] == null ? [] : List<SubjectModelItem>.from(json["items"]!.map((x) => SubjectModelItem.fromJson(x))),
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

class SubjectModelItem {
  String? title;
  String? description;
  List<Course>? courses;
  String? id;
  bool? isDeleted;

  SubjectModelItem({
    this.title,
    this.description,
    this.courses,
    this.id,
    this.isDeleted,
  });

  factory SubjectModelItem.fromJson(Map<String, dynamic> json) => SubjectModelItem(
    title: json["title"],
    description: json["description"],
    courses: json["courses"] == null ? [] : List<Course>.from(json["courses"]!.map((x) => Course.fromJson(x))),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x.toJson())),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Course {
  String? title;
  String? imageUrl;
  String? description;
  int? price;
  int? totalSlot;
  String? subjectId;
  dynamic subject;
  String? programTypeId;
  dynamic programType;
  String? courseLevelId;
  dynamic courseLevel;
  List<dynamic>? teachables;
  List<dynamic>? chapters;
  List<dynamic>? enrollments;
  String? id;
  bool? isDeleted;

  Course({
    this.title,
    this.imageUrl,
    this.description,
    this.price,
    this.totalSlot,
    this.subjectId,
    this.subject,
    this.programTypeId,
    this.programType,
    this.courseLevelId,
    this.courseLevel,
    this.teachables,
    this.chapters,
    this.enrollments,
    this.id,
    this.isDeleted,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    title: json["title"],
    imageUrl: json["imageURL"],
    description: json["description"],
    price: json["price"],
    totalSlot: json["totalSlot"],
    subjectId: json["subjectId"],
    subject: json["subject"],
    programTypeId: json["programTypeId"],
    programType: json["programType"],
    courseLevelId: json["courseLevelId"],
    courseLevel: json["courseLevel"],
    teachables: json["teachables"] == null ? [] : List<dynamic>.from(json["teachables"]!.map((x) => x)),
    chapters: json["chapters"] == null ? [] : List<dynamic>.from(json["chapters"]!.map((x) => x)),
    enrollments: json["enrollments"] == null ? [] : List<dynamic>.from(json["enrollments"]!.map((x) => x)),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "imageURL": imageUrl,
    "description": description,
    "price": price,
    "totalSlot": totalSlot,
    "subjectId": subjectId,
    "subject": subject,
    "programTypeId": programTypeId,
    "programType": programType,
    "courseLevelId": courseLevelId,
    "courseLevel": courseLevel,
    "teachables": teachables == null ? [] : List<dynamic>.from(teachables!.map((x) => x)),
    "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x)),
    "enrollments": enrollments == null ? [] : List<dynamic>.from(enrollments!.map((x) => x)),
    "id": id,
    "isDeleted": isDeleted,
  };
}
