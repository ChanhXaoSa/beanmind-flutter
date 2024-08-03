// To parse this JSON data, do
//
//     final worksheetTemplateDetailModel = worksheetTemplateDetailModelFromJson(jsonString);

import 'dart:convert';

WorksheetTemplateDetailModel worksheetTemplateDetailModelFromJson(String str) => WorksheetTemplateDetailModel.fromJson(json.decode(str));

String worksheetTemplateDetailModelToJson(WorksheetTemplateDetailModel data) => json.encode(data.toJson());

class WorksheetTemplateDetailModel {
  String? message;
  bool? success;
  int? code;
  WorksheetTemplateDetailData? data;
  dynamic errors;
  dynamic fieldErrors;

  WorksheetTemplateDetailModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory WorksheetTemplateDetailModel.fromJson(Map<String, dynamic> json) => WorksheetTemplateDetailModel(
    message: json["message"],
    success: json["success"],
    code: json["code"],
    data: json["data"] == null ? null : WorksheetTemplateDetailData.fromJson(json["data"]),
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

class WorksheetTemplateDetailData {
  String? title;
  int? classification;
  String? courseId;
  Course? course;
  dynamic chapterId;
  dynamic chapter;
  dynamic topicId;
  dynamic topic;
  List<Worksheet>? worksheets;
  List<LevelTemplateRelation>? levelTemplateRelations;
  String? id;
  bool? isDeleted;

  WorksheetTemplateDetailData({
    this.title,
    this.classification,
    this.courseId,
    this.course,
    this.chapterId,
    this.chapter,
    this.topicId,
    this.topic,
    this.worksheets,
    this.levelTemplateRelations,
    this.id,
    this.isDeleted,
  });

  factory WorksheetTemplateDetailData.fromJson(Map<String, dynamic> json) => WorksheetTemplateDetailData(
    title: json["title"],
    classification: json["classification"],
    courseId: json["courseId"],
    course: json["course"] == null ? null : Course.fromJson(json["course"]),
    chapterId: json["chapterId"],
    chapter: json["chapter"],
    topicId: json["topicId"],
    topic: json["topic"],
    worksheets: json["worksheets"] == null ? [] : List<Worksheet>.from(json["worksheets"]!.map((x) => Worksheet.fromJson(x))),
    levelTemplateRelations: json["levelTemplateRelations"] == null ? [] : List<LevelTemplateRelation>.from(json["levelTemplateRelations"]!.map((x) => LevelTemplateRelation.fromJson(x))),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "classification": classification,
    "courseId": courseId,
    "course": course?.toJson(),
    "chapterId": chapterId,
    "chapter": chapter,
    "topicId": topicId,
    "topic": topic,
    "worksheets": worksheets == null ? [] : List<dynamic>.from(worksheets!.map((x) => x.toJson())),
    "levelTemplateRelations": levelTemplateRelations == null ? [] : List<dynamic>.from(levelTemplateRelations!.map((x) => x.toJson())),
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
    "id": id,
    "isDeleted": isDeleted,
  };
}

class LevelTemplateRelation {
  String? questionLevelId;
  dynamic questionLevel;
  String? worksheetTemplateId;
  WorksheetTemplate? worksheetTemplate;
  int? questionCount;
  String? id;
  bool? isDeleted;

  LevelTemplateRelation({
    this.questionLevelId,
    this.questionLevel,
    this.worksheetTemplateId,
    this.worksheetTemplate,
    this.questionCount,
    this.id,
    this.isDeleted,
  });

  factory LevelTemplateRelation.fromJson(Map<String, dynamic> json) => LevelTemplateRelation(
    questionLevelId: json["questionLevelId"],
    questionLevel: json["questionLevel"],
    worksheetTemplateId: json["worksheetTemplateId"],
    worksheetTemplate: json["worksheetTemplate"] == null ? null : WorksheetTemplate.fromJson(json["worksheetTemplate"]),
    questionCount: json["questionCount"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "questionLevelId": questionLevelId,
    "questionLevel": questionLevel,
    "worksheetTemplateId": worksheetTemplateId,
    "worksheetTemplate": worksheetTemplate?.toJson(),
    "questionCount": questionCount,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class WorksheetTemplate {
  String? title;
  int? classification;
  String? courseId;
  dynamic chapterId;
  dynamic topicId;
  String? id;
  bool? isDeleted;

  WorksheetTemplate({
    this.title,
    this.classification,
    this.courseId,
    this.chapterId,
    this.topicId,
    this.id,
    this.isDeleted,
  });

  factory WorksheetTemplate.fromJson(Map<String, dynamic> json) => WorksheetTemplate(
    title: json["title"],
    classification: json["classification"],
    courseId: json["courseId"],
    chapterId: json["chapterId"],
    topicId: json["topicId"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "classification": classification,
    "courseId": courseId,
    "chapterId": chapterId,
    "topicId": topicId,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Worksheet {
  String? title;
  String? description;
  String? worksheetTemplateId;
  String? id;
  bool? isDeleted;

  Worksheet({
    this.title,
    this.description,
    this.worksheetTemplateId,
    this.id,
    this.isDeleted,
  });

  factory Worksheet.fromJson(Map<String, dynamic> json) => Worksheet(
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
