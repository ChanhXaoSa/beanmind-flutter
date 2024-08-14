// To parse this JSON data, do
//
//     final worksheetAttemptAnswerModel = worksheetAttemptAnswerModelFromJson(jsonString);

import 'dart:convert';

WorksheetAttemptAnswerModel worksheetAttemptAnswerModelFromJson(String str) => WorksheetAttemptAnswerModel.fromJson(json.decode(str));

String worksheetAttemptAnswerModelToJson(WorksheetAttemptAnswerModel data) => json.encode(data.toJson());

class WorksheetAttemptAnswerModel {
  String? message;
  bool? success;
  int? code;
  Data? data;
  dynamic errors;
  dynamic fieldErrors;

  WorksheetAttemptAnswerModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory WorksheetAttemptAnswerModel.fromJson(Map<String, dynamic> json) => WorksheetAttemptAnswerModel(
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
  List<WorksheetAttemptAnswerModelItem>? items;
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
    items: json["items"] == null ? [] : List<WorksheetAttemptAnswerModelItem>.from(json["items"]!.map((x) => WorksheetAttemptAnswerModelItem.fromJson(x))),
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

class WorksheetAttemptAnswerModelItem {
  String? worksheetAttemptId;
  WorksheetAttempt? worksheetAttempt;
  String? questionAnswerId;
  QuestionAnswer? questionAnswer;
  String? id;
  bool? isDeleted;

  WorksheetAttemptAnswerModelItem({
    this.worksheetAttemptId,
    this.worksheetAttempt,
    this.questionAnswerId,
    this.questionAnswer,
    this.id,
    this.isDeleted,
  });

  factory WorksheetAttemptAnswerModelItem.fromJson(Map<String, dynamic> json) => WorksheetAttemptAnswerModelItem(
    worksheetAttemptId: json["worksheetAttemptId"],
    worksheetAttempt: json["worksheetAttempt"] == null ? null : WorksheetAttempt.fromJson(json["worksheetAttempt"]),
    questionAnswerId: json["questionAnswerId"],
    questionAnswer: json["questionAnswer"] == null ? null : QuestionAnswer.fromJson(json["questionAnswer"]),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "worksheetAttemptId": worksheetAttemptId,
    "worksheetAttempt": worksheetAttempt?.toJson(),
    "questionAnswerId": questionAnswerId,
    "questionAnswer": questionAnswer?.toJson(),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class QuestionAnswer {
  String? questionId;
  dynamic question;
  String? content;
  bool? isCorrect;
  bool? isDeleted;
  String? id;

  QuestionAnswer({
    this.questionId,
    this.question,
    this.content,
    this.isCorrect,
    this.isDeleted,
    this.id,
  });

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) => QuestionAnswer(
    questionId: json["questionId"],
    question: json["question"],
    content: json["content"],
    isCorrect: json["isCorrect"],
    isDeleted: json["isDeleted"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "question": question,
    "content": content,
    "isCorrect": isCorrect,
    "isDeleted": isDeleted,
    "id": id,
  };
}

class WorksheetAttempt {
  String? enrollmentId;
  dynamic enrollment;
  String? worksheetId;
  dynamic worksheet;
  DateTime? completionDate;
  int? status;
  int? score;
  String? id;
  bool? isDeleted;

  WorksheetAttempt({
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

  factory WorksheetAttempt.fromJson(Map<String, dynamic> json) => WorksheetAttempt(
    enrollmentId: json["enrollmentId"],
    enrollment: json["enrollment"],
    worksheetId: json["worksheetId"],
    worksheet: json["worksheet"],
    completionDate: json["completionDate"] == null ? null : DateTime.parse(json["completionDate"]),
    status: json["status"],
    score: json["score"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "enrollmentId": enrollmentId,
    "enrollment": enrollment,
    "worksheetId": worksheetId,
    "worksheet": worksheet,
    "completionDate": completionDate?.toIso8601String(),
    "status": status,
    "score": score,
    "id": id,
    "isDeleted": isDeleted,
  };
}
