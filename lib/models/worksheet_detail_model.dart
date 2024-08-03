// To parse this JSON data, do
//
//     final worksheetDetailModel = worksheetDetailModelFromJson(jsonString);

import 'dart:convert';

WorksheetDetailModel worksheetDetailModelFromJson(String str) => WorksheetDetailModel.fromJson(json.decode(str));

String worksheetDetailModelToJson(WorksheetDetailModel data) => json.encode(data.toJson());

class WorksheetDetailModel {
  String? message;
  bool? success;
  int? code;
  Data? data;
  dynamic errors;
  dynamic fieldErrors;

  WorksheetDetailModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory WorksheetDetailModel.fromJson(Map<String, dynamic> json) => WorksheetDetailModel(
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
  String? worksheetTemplateId;
  WorksheetTemplate? worksheetTemplate;
  List<WorksheetQuestion>? worksheetQuestions;
  List<dynamic>? worksheetAttempts;
  String? id;
  bool? isDeleted;

  Data({
    this.title,
    this.description,
    this.worksheetTemplateId,
    this.worksheetTemplate,
    this.worksheetQuestions,
    this.worksheetAttempts,
    this.id,
    this.isDeleted,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    description: json["description"],
    worksheetTemplateId: json["worksheetTemplateId"],
    worksheetTemplate: json["worksheetTemplate"] == null ? null : WorksheetTemplate.fromJson(json["worksheetTemplate"]),
    worksheetQuestions: json["worksheetQuestions"] == null ? [] : List<WorksheetQuestion>.from(json["worksheetQuestions"]!.map((x) => WorksheetQuestion.fromJson(x))),
    worksheetAttempts: json["worksheetAttempts"] == null ? [] : List<dynamic>.from(json["worksheetAttempts"]!.map((x) => x)),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "worksheetTemplateId": worksheetTemplateId,
    "worksheetTemplate": worksheetTemplate?.toJson(),
    "worksheetQuestions": worksheetQuestions == null ? [] : List<dynamic>.from(worksheetQuestions!.map((x) => x.toJson())),
    "worksheetAttempts": worksheetAttempts == null ? [] : List<dynamic>.from(worksheetAttempts!.map((x) => x)),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class WorksheetQuestion {
  String? questionId;
  Question? question;
  String? worksheetId;
  Worksheet? worksheet;
  String? id;
  bool? isDeleted;

  WorksheetQuestion({
    this.questionId,
    this.question,
    this.worksheetId,
    this.worksheet,
    this.id,
    this.isDeleted,
  });

  factory WorksheetQuestion.fromJson(Map<String, dynamic> json) => WorksheetQuestion(
    questionId: json["questionId"],
    question: json["question"] == null ? null : Question.fromJson(json["question"]),
    worksheetId: json["worksheetId"],
    worksheet: json["worksheet"] == null ? null : Worksheet.fromJson(json["worksheet"]),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "question": question?.toJson(),
    "worksheetId": worksheetId,
    "worksheet": worksheet?.toJson(),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Question {
  String? content;
  dynamic imageUrl;
  String? topicId;
  dynamic topic;
  String? questionLevelId;
  dynamic questionLevel;
  List<QuestionAnswer>? questionAnswers;
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
    topic: json["topic"],
    questionLevelId: json["questionLevelId"],
    questionLevel: json["questionLevel"],
    questionAnswers: json["questionAnswers"] == null ? [] : List<QuestionAnswer>.from(json["questionAnswers"]!.map((x) => QuestionAnswer.fromJson(x))),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "imageUrl": imageUrl,
    "topicId": topicId,
    "topic": topic,
    "questionLevelId": questionLevelId,
    "questionLevel": questionLevel,
    "questionAnswers": questionAnswers == null ? [] : List<dynamic>.from(questionAnswers!.map((x) => x.toJson())),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class QuestionAnswer {
  String? questionId;
  dynamic question;
  String? content;
  bool? isCorrect;
  String? id;
  bool? isDeleted;

  QuestionAnswer({
    this.questionId,
    this.question,
    this.content,
    this.isCorrect,
    this.id,
    this.isDeleted,
  });

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) => QuestionAnswer(
    questionId: json["questionId"],
    question: json["question"],
    content: json["content"],
    isCorrect: json["isCorrect"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "question": question,
    "content": content,
    "isCorrect": isCorrect,
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
