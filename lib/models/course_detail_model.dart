// To parse this JSON data, do
//
//     final courseDetailModel = courseDetailModelFromJson(jsonString);

import 'dart:convert';

CourseDetailModel courseDetailModelFromJson(String str) => CourseDetailModel.fromJson(json.decode(str));

String courseDetailModelToJson(CourseDetailModel data) => json.encode(data.toJson());

class CourseDetailModel {
  String? message;
  bool? success;
  int? code;
  Data? data;
  dynamic errors;
  dynamic fieldErrors;

  CourseDetailModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) => CourseDetailModel(
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
  String? title;
  String? description;
  int? totalSlot;
  String? subjectId;
  CourseLevel? subject;
  String? programTypeId;
  CourseLevel? programType;
  String? courseLevelId;
  CourseLevel? courseLevel;
  List<TeachingSlot>? teachingSlots;
  List<Enrollment>? teachables;
  List<CourseLevel>? chapters;
  List<Enrollment>? enrollments;
  List<dynamic>? worksheetTemplates;
  String? id;
  bool? isDeleted;

  Data({
    this.title,
    this.description,
    this.totalSlot,
    this.subjectId,
    this.subject,
    this.programTypeId,
    this.programType,
    this.courseLevelId,
    this.courseLevel,
    this.teachingSlots,
    this.teachables,
    this.chapters,
    this.enrollments,
    this.worksheetTemplates,
    this.id,
    this.isDeleted,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    description: json["description"],
    totalSlot: json["totalSlot"],
    subjectId: json["subjectId"],
    subject: json["subject"] == null ? null : CourseLevel.fromJson(json["subject"]),
    programTypeId: json["programTypeId"],
    programType: json["programType"] == null ? null : CourseLevel.fromJson(json["programType"]),
    courseLevelId: json["courseLevelId"],
    courseLevel: json["courseLevel"] == null ? null : CourseLevel.fromJson(json["courseLevel"]),
    teachingSlots: json["teachingSlots"] == null ? [] : List<TeachingSlot>.from(json["teachingSlots"]!.map((x) => TeachingSlot.fromJson(x))),
    teachables: json["teachables"] == null ? [] : List<Enrollment>.from(json["teachables"]!.map((x) => Enrollment.fromJson(x))),
    chapters: json["chapters"] == null ? [] : List<CourseLevel>.from(json["chapters"]!.map((x) => CourseLevel.fromJson(x))),
    enrollments: json["enrollments"] == null ? [] : List<Enrollment>.from(json["enrollments"]!.map((x) => Enrollment.fromJson(x))),
    worksheetTemplates: json["worksheetTemplates"] == null ? [] : List<dynamic>.from(json["worksheetTemplates"]!.map((x) => x)),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "totalSlot": totalSlot,
    "subjectId": subjectId,
    "subject": subject?.toJson(),
    "programTypeId": programTypeId,
    "programType": programType?.toJson(),
    "courseLevelId": courseLevelId,
    "courseLevel": courseLevel?.toJson(),
    "teachingSlots": teachingSlots == null ? [] : List<dynamic>.from(teachingSlots!.map((x) => x.toJson())),
    "teachables": teachables == null ? [] : List<dynamic>.from(teachables!.map((x) => x.toJson())),
    "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x.toJson())),
    "enrollments": enrollments == null ? [] : List<dynamic>.from(enrollments!.map((x) => x.toJson())),
    "worksheetTemplates": worksheetTemplates == null ? [] : List<dynamic>.from(worksheetTemplates!.map((x) => x)),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class CourseLevel {
  String? title;
  String? description;
  String? courseId;
  String? id;
  bool? isDeleted;

  CourseLevel({
    this.title,
    this.description,
    this.courseId,
    this.id,
    this.isDeleted,
  });

  factory CourseLevel.fromJson(Map<String, dynamic> json) => CourseLevel(
    title: json["title"],
    description: json["description"],
    courseId: json["courseId"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "courseId": courseId,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Enrollment {
  String? applicationUserId;
  String? courseId;
  bool? status;
  String? id;
  bool? isDeleted;

  Enrollment({
    this.applicationUserId,
    this.courseId,
    this.status,
    this.id,
    this.isDeleted,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) => Enrollment(
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

class TeachingSlot {
  String? title;
  int? dayInWeek;
  int? slot;
  String? courseId;
  String? id;
  bool? isDeleted;

  TeachingSlot({
    this.title,
    this.dayInWeek,
    this.slot,
    this.courseId,
    this.id,
    this.isDeleted,
  });

  factory TeachingSlot.fromJson(Map<String, dynamic> json) => TeachingSlot(
    title: json["title"],
    dayInWeek: json["dayInWeek"],
    slot: json["slot"],
    courseId: json["courseId"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "dayInWeek": dayInWeek,
    "slot": slot,
    "courseId": courseId,
    "id": id,
    "isDeleted": isDeleted,
  };
}
