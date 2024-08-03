// To parse this JSON data, do
//
//     final topicDetailModel = topicDetailModelFromJson(jsonString);

import 'dart:convert';

TopicDetailModel topicDetailModelFromJson(String str) => TopicDetailModel.fromJson(json.decode(str));

String topicDetailModelToJson(TopicDetailModel data) => json.encode(data.toJson());

class TopicDetailModel {
  String? message;
  bool? success;
  int? code;
  TopicDetailData? data;
  dynamic errors;
  dynamic fieldErrors;

  TopicDetailModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory TopicDetailModel.fromJson(Map<String, dynamic> json) => TopicDetailModel(
    message: json["message"],
    success: json["success"],
    code: json["code"],
    data: json["data"] == null ? null : TopicDetailData.fromJson(json["data"]),
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

class TopicDetailData {
  String? title;
  String? description;
  String? chapterId;
  Chapter? chapter;
  List<Question>? questions;
  List<dynamic>? worksheetTemplates;
  List<dynamic>? processions;
  String? id;
  bool? isDeleted;

  TopicDetailData({
    this.title,
    this.description,
    this.chapterId,
    this.chapter,
    this.questions,
    this.worksheetTemplates,
    this.processions,
    this.id,
    this.isDeleted,
  });

  factory TopicDetailData.fromJson(Map<String, dynamic> json) => TopicDetailData(
    title: json["title"],
    description: json["description"],
    chapterId: json["chapterId"],
    chapter: json["chapter"] == null ? null : Chapter.fromJson(json["chapter"]),
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
    worksheetTemplates: json["worksheetTemplates"] == null ? [] : List<dynamic>.from(json["worksheetTemplates"]!.map((x) => x)),
    processions: json["processions"] == null ? [] : List<dynamic>.from(json["processions"]!.map((x) => x)),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "chapterId": chapterId,
    "chapter": chapter?.toJson(),
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
    "worksheetTemplates": worksheetTemplates == null ? [] : List<dynamic>.from(worksheetTemplates!.map((x) => x)),
    "processions": processions == null ? [] : List<dynamic>.from(processions!.map((x) => x)),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Chapter {
  String? title;
  String? description;
  int? order;
  String? courseId;
  dynamic course;
  List<dynamic>? topics;
  String? id;
  bool? isDeleted;

  Chapter({
    this.title,
    this.description,
    this.order,
    this.courseId,
    this.course,
    this.topics,
    this.id,
    this.isDeleted,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    title: json["title"],
    description: json["description"],
    order: json["order"],
    courseId: json["courseId"],
    course: json["course"],
    topics: json["topics"] == null ? [] : List<dynamic>.from(json["topics"]!.map((x) => x)),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "order": order,
    "courseId": courseId,
    "course": course,
    "topics": topics == null ? [] : List<dynamic>.from(topics!.map((x) => x)),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Question {
  String? content;
  dynamic imageUrl;
  String? topicId;
  Topic? topic;
  String? questionLevelId;
  dynamic questionLevel;
  List<dynamic>? questionAnswers;
  String? id;
  bool? isDeleted;

  Question({
    this.content,
    this.imageUrl,
    this.topicId,
    this.topic,
    this.questionLevelId,
    this.questionLevel,
    this.questionAnswers,
    this.id,
    this.isDeleted,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    content: json["content"],
    imageUrl: json["imageUrl"],
    topicId: json["topicId"],
    topic: json["topic"] == null ? null : Topic.fromJson(json["topic"]),
    questionLevelId: json["questionLevelId"],
    questionLevel: json["questionLevel"],
    questionAnswers: json["questionAnswers"] == null ? [] : List<dynamic>.from(json["questionAnswers"]!.map((x) => x)),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "imageUrl": imageUrl,
    "topicId": topicId,
    "topic": topic?.toJson(),
    "questionLevelId": questionLevelId,
    "questionLevel": questionLevel,
    "questionAnswers": questionAnswers == null ? [] : List<dynamic>.from(questionAnswers!.map((x) => x)),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Topic {
  String? title;
  String? description;
  String? chapterId;
  Chapter? chapter;
  String? id;
  bool? isDeleted;

  Topic({
    this.title,
    this.description,
    this.chapterId,
    this.chapter,
    this.id,
    this.isDeleted,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    title: json["title"],
    description: json["description"],
    chapterId: json["chapterId"],
    chapter: json["chapter"] == null ? null : Chapter.fromJson(json["chapter"]),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "chapterId": chapterId,
    "chapter": chapter?.toJson(),
    "id": id,
    "isDeleted": isDeleted,
  };
}
