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
  List<CourseModelItem>? items;
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
    items: json["items"] == null ? [] : List<CourseModelItem>.from(json["items"]!.map((x) => CourseModelItem.fromJson(x))),
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

class CourseLevel {
  String? title;
  String? description;
  String? id;
  bool? isDeleted;
  List<CourseModelItem?>? courses;

  CourseLevel({
    this.title,
    this.description,
    this.id,
    this.isDeleted,
    this.courses,
  });

  factory CourseLevel.fromJson(Map<String, dynamic> json) => CourseLevel(
    title: json["title"],
    description: json["description"],
    id: json["id"],
    isDeleted: json["isDeleted"],
    courses: json["courses"] == null ? [] : List<CourseModelItem?>.from(json["courses"]!.map((x) => x == null ? null : CourseModelItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "id": id,
    "isDeleted": isDeleted,
    "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x?.toJson())),
  };
}

class CourseModelItem {
  String? title;
  String? contentURL;
  String? imageUrl;
  String? description;
  int? price;
  int? totalSlot;
  String? subjectId;
  CourseLevel? subject;
  String? programTypeId;
  CourseLevel? programType;
  String? courseLevelId;
  CourseLevel? courseLevel;
  List<Teachable>? teachables;
  List<dynamic>? chapters;
  List<dynamic>? enrollments;
  int? numberOfEnrollment;
  String? id;
  bool? isDeleted;

  CourseModelItem({
    this.title,
    this.contentURL,
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
    this.numberOfEnrollment,
    this.id,
    this.isDeleted,
  });

  factory CourseModelItem.fromJson(Map<String, dynamic> json) => CourseModelItem(
    title: json["title"],
    contentURL : json["contentURL"],
    imageUrl: json["imageURL"],
    description: json["description"],
    price: json["price"],
    totalSlot: json["totalSlot"],
    subjectId: json["subjectId"],
    subject: json["subject"] == null ? null : CourseLevel.fromJson(json["subject"]),
    programTypeId: json["programTypeId"],
    programType: json["programType"] == null ? null : CourseLevel.fromJson(json["programType"]),
    courseLevelId: json["courseLevelId"],
    courseLevel: json["courseLevel"] == null ? null : CourseLevel.fromJson(json["courseLevel"]),
    teachables: json["teachables"] == null ? [] : List<Teachable>.from(json["teachables"]!.map((x) => Teachable.fromJson(x))),
    chapters: json["chapters"] == null ? [] : List<dynamic>.from(json["chapters"]!.map((x) => x)),
    enrollments: json["enrollments"] == null ? [] : List<dynamic>.from(json["enrollments"]!.map((x) => x)),
    numberOfEnrollment: json["numberOfEnrollment"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "contentURL" : contentURL,
    "imageURL": imageUrl,
    "description": description,
    "price": price,
    "totalSlot": totalSlot,
    "subjectId": subjectId,
    "subject": subject?.toJson(),
    "programTypeId": programTypeId,
    "programType": programType?.toJson(),
    "courseLevelId": courseLevelId,
    "courseLevel": courseLevel?.toJson(),
    "teachables": teachables == null ? [] : List<dynamic>.from(teachables!.map((x) => x.toJson())),
    "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x)),
    "enrollments": enrollments == null ? [] : List<dynamic>.from(enrollments!.map((x) => x)),
    "numberOfEnrollment" : numberOfEnrollment,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Teachable {
  String? applicationUserId;
  dynamic applicationUser;
  String? courseId;
  dynamic course;
  String? id;
  bool? isDeleted;

  Teachable({
    this.applicationUserId,
    this.applicationUser,
    this.courseId,
    this.course,
    this.id,
    this.isDeleted,
  });

  factory Teachable.fromJson(Map<String, dynamic> json) => Teachable(
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"],
    courseId: json["courseId"],
    course: json["course"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "applicationUserId": applicationUserId,
    "applicationUser": applicationUser,
    "courseId": courseId,
    "course": course,
    "id": id,
    "isDeleted": isDeleted,
  };
}
