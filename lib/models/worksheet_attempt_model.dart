// To parse this JSON data, do
//
//     final worksheetAttemptModel = worksheetAttemptModelFromJson(jsonString);

import 'dart:convert';

WorksheetAttemptModel worksheetAttemptModelFromJson(String str) => WorksheetAttemptModel.fromJson(json.decode(str));

String worksheetAttemptModelToJson(WorksheetAttemptModel data) => json.encode(data.toJson());

class WorksheetAttemptModel {
  String? message;
  bool? success;
  int? code;
  Data? data;
  dynamic errors;
  dynamic fieldErrors;

  WorksheetAttemptModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory WorksheetAttemptModel.fromJson(Map<String, dynamic> json) => WorksheetAttemptModel(
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
  List<WorksheetAttemptItem>? items;
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
    items: json["items"] == null ? [] : List<WorksheetAttemptItem>.from(json["items"]!.map((x) => WorksheetAttemptItem.fromJson(x))),
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

class WorksheetAttemptItem {
  String? enrollmentId;
  Enrollment? enrollment;
  String? worksheetId;
  Worksheet? worksheet;
  DateTime? completionDate;
  int? status;
  int? score;
  String? id;
  bool? isDeleted;

  WorksheetAttemptItem({
    this.enrollmentId,
    this.enrollment,
    this.worksheetId,
    this.worksheet,
    this.completionDate,
    this.status,
    this.score,
    this.id,
    this.isDeleted,
  });

  factory WorksheetAttemptItem.fromJson(Map<String, dynamic> json) => WorksheetAttemptItem(
    enrollmentId: json["enrollmentId"],
    enrollment: json["enrollment"] == null ? null : Enrollment.fromJson(json["enrollment"]),
    worksheetId: json["worksheetId"],
    worksheet: json["worksheet"] == null ? null : Worksheet.fromJson(json["worksheet"]),
    completionDate: json["completionDate"] == null ? null : DateTime.parse(json["completionDate"]),
    status: json["status"],
    score: json["score"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "enrollmentId": enrollmentId,
    "enrollment": enrollment?.toJson(),
    "worksheetId": worksheetId,
    "worksheet": worksheet?.toJson(),
    "completionDate": completionDate?.toIso8601String(),
    "status": status,
    "score": score,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Enrollment {
  String? applicationUserId;
  dynamic applicationUser;
  String? courseId;
  dynamic course;
  int? status;
  int? percentTopicCompletion;
  int? percentWorksheetCompletion;
  String? id;
  bool? isDeleted;

  Enrollment({
    this.applicationUserId,
    this.applicationUser,
    this.courseId,
    this.course,
    this.status,
    this.percentTopicCompletion,
    this.percentWorksheetCompletion,
    this.id,
    this.isDeleted,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) => Enrollment(
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"],
    courseId: json["courseId"],
    course: json["course"],
    status: json["status"],
    percentTopicCompletion: json["percentTopicCompletion"],
    percentWorksheetCompletion: json["percentWorksheetCompletion"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "applicationUserId": applicationUserId,
    "applicationUser": applicationUser,
    "courseId": courseId,
    "course": course,
    "status": status,
    "percentTopicCompletion": percentTopicCompletion,
    "percentWorksheetCompletion": percentWorksheetCompletion,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Worksheet {
  String? title;
  String? description;
  String? worksheetTemplateId;
  dynamic worksheetTemplate;
  List<dynamic>? worksheetQuestions;
  String? id;
  bool? isDeleted;

  Worksheet({
    this.title,
    this.description,
    this.worksheetTemplateId,
    this.worksheetTemplate,
    this.worksheetQuestions,
    this.id,
    this.isDeleted,
  });

  factory Worksheet.fromJson(Map<String, dynamic> json) => Worksheet(
    title: json["title"],
    description: json["description"],
    worksheetTemplateId: json["worksheetTemplateId"],
    worksheetTemplate: json["worksheetTemplate"],
    worksheetQuestions: json["worksheetQuestions"] == null ? [] : List<dynamic>.from(json["worksheetQuestions"]!.map((x) => x)),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "worksheetTemplateId": worksheetTemplateId,
    "worksheetTemplate": worksheetTemplate,
    "worksheetQuestions": worksheetQuestions == null ? [] : List<dynamic>.from(worksheetQuestions!.map((x) => x)),
    "id": id,
    "isDeleted": isDeleted,
  };
}
