// To parse this JSON data, do
//
//     final worksheetAttemptDetailModel = worksheetAttemptDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:beanmind_flutter/models/worksheet_detail_model.dart';

WorksheetAttemptDetailModel worksheetAttemptDetailModelFromJson(String str) => WorksheetAttemptDetailModel.fromJson(json.decode(str));

String worksheetAttemptDetailModelToJson(WorksheetAttemptDetailModel data) => json.encode(data.toJson());

class WorksheetAttemptDetailModel {
  String? message;
  bool? success;
  int? code;
  WorksheetAttemptDetailModelData? data;
  dynamic errors;
  dynamic fieldErrors;

  WorksheetAttemptDetailModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory WorksheetAttemptDetailModel.fromJson(Map<String, dynamic> json) => WorksheetAttemptDetailModel(
    message: json["message"],
    success: json["success"],
    code: json["code"],
    data: json["data"] == null ? null : WorksheetAttemptDetailModelData.fromJson(json["data"]),
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

class WorksheetAttemptAnswer {
  String? worksheetAttemptId;
  WorksheetAttemptDetailModelData? worksheetAttempt;
  String? questionAnswerId;
  QuestionAnswer? questionAnswer;
  DateTime? created;
  String? id;
  bool? isDeleted;

  WorksheetAttemptAnswer({
    this.worksheetAttemptId,
    this.worksheetAttempt,
    this.questionAnswerId,
    this.questionAnswer,
    this.created,
    this.id,
    this.isDeleted,
  });

  factory WorksheetAttemptAnswer.fromJson(Map<String, dynamic> json) => WorksheetAttemptAnswer(
    worksheetAttemptId: json["worksheetAttemptId"],
    worksheetAttempt: json["worksheetAttempt"] == null ? null : WorksheetAttemptDetailModelData.fromJson(json["worksheetAttempt"]),
    questionAnswerId: json["questionAnswerId"],
    questionAnswer: json["questionAnswer"] == null ? null : QuestionAnswer.fromJson(json["questionAnswer"]),
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "worksheetAttemptId": worksheetAttemptId,
    "worksheetAttempt": worksheetAttempt?.toJson(),
    "questionAnswerId": questionAnswerId,
    "questionAnswer": questionAnswer?.toJson(),
    "created": created?.toIso8601String(),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class WorksheetAttemptDetailModelData {
  String? enrollmentId;
  Enrollment? enrollment;
  String? worksheetId;
  Worksheet? worksheet;
  DateTime? completionDate;
  int? status;
  int? score;
  List<WorksheetAttemptAnswer>? worksheetAttemptAnswers;
  DateTime? created;
  String? id;
  bool? isDeleted;

  WorksheetAttemptDetailModelData({
    this.enrollmentId,
    this.enrollment,
    this.worksheetId,
    this.worksheet,
    this.completionDate,
    this.status,
    this.score,
    this.worksheetAttemptAnswers,
    this.created,
    this.id,
    this.isDeleted,
  });

  factory WorksheetAttemptDetailModelData.fromJson(Map<String, dynamic> json) => WorksheetAttemptDetailModelData(
    enrollmentId: json["enrollmentId"],
    enrollment: json["enrollment"] == null ? null : Enrollment.fromJson(json["enrollment"]),
    worksheetId: json["worksheetId"],
    worksheet: json["worksheet"] == null ? null : Worksheet.fromJson(json["worksheet"]),
    completionDate: json["completionDate"] == null ? null : DateTime.parse(json["completionDate"]),
    status: json["status"],
    score: json["score"],
    worksheetAttemptAnswers: json["worksheetAttemptAnswers"] == null ? [] : List<WorksheetAttemptAnswer>.from(json["worksheetAttemptAnswers"]!.map((x) => WorksheetAttemptAnswer.fromJson(x))),
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
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
    "worksheetAttemptAnswers": worksheetAttemptAnswers == null ? [] : List<dynamic>.from(worksheetAttemptAnswers!.map((x) => x.toJson())),
    "created": created?.toIso8601String(),
    "id": id,
    "isDeleted": isDeleted,
  };
}

// class QuestionAnswer {
//   String? questionId;
//   Question? question;
//   String? content;
//   bool? isCorrect;
//   bool? isDeleted;
//   DateTime? created;
//   String? id;
//
//   QuestionAnswer({
//     this.questionId,
//     this.question,
//     this.content,
//     this.isCorrect,
//     this.isDeleted,
//     this.created,
//     this.id,
//   });
//
//   factory QuestionAnswer.fromJson(Map<String, dynamic> json) => QuestionAnswer(
//     questionId: json["questionId"],
//     question: json["question"] == null ? null : Question.fromJson(json["question"]),
//     content: json["content"],
//     isCorrect: json["isCorrect"],
//     isDeleted: json["isDeleted"],
//     created: json["created"] == null ? null : DateTime.parse(json["created"]),
//     id: json["id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "questionId": questionId,
//     "question": question?.toJson(),
//     "content": content,
//     "isCorrect": isCorrect,
//     "isDeleted": isDeleted,
//     "created": created?.toIso8601String(),
//     "id": id,
//   };
// }

class Question {
  String? content;
  dynamic imageUrl;
  String? topicId;
  dynamic topic;
  String? questionLevelId;
  dynamic questionLevel;
  List<dynamic>? questionAnswers;
  DateTime? created;
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
    this.created,
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
    questionAnswers: json["questionAnswers"] == null ? [] : List<dynamic>.from(json["questionAnswers"]!.map((x) => x)),
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
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
    "questionAnswers": questionAnswers == null ? [] : List<dynamic>.from(questionAnswers!.map((x) => x)),
    "created": created?.toIso8601String(),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class WorksheetAttempt {
  String? enrollmentId;
  Enrollment? enrollment;
  String? worksheetId;
  Worksheet? worksheet;
  DateTime? completionDate;
  int? status;
  int? score;
  DateTime? created;
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
    this.created,
    this.id,
    this.isDeleted,
  });

  factory WorksheetAttempt.fromJson(Map<String, dynamic> json) => WorksheetAttempt(
    enrollmentId: json["enrollmentId"],
    enrollment: json["enrollment"] == null ? null : Enrollment.fromJson(json["enrollment"]),
    worksheetId: json["worksheetId"],
    worksheet: json["worksheet"] == null ? null : Worksheet.fromJson(json["worksheet"]),
    completionDate: json["completionDate"] == null ? null : DateTime.parse(json["completionDate"]),
    status: json["status"],
    score: json["score"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
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
    "created": created?.toIso8601String(),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class ApplicationUser {
  String? id;
  String? userName;
  String? lastName;
  String? firstName;
  dynamic yearOfBirth;
  String? email;
  bool? isDeleted;
  String? studentId;
  dynamic student;
  dynamic teacherId;
  dynamic teacher;
  dynamic parentId;
  dynamic parent;
  List<Enrollment>? enrollments;

  ApplicationUser({
    this.id,
    this.userName,
    this.lastName,
    this.firstName,
    this.yearOfBirth,
    this.email,
    this.isDeleted,
    this.studentId,
    this.student,
    this.teacherId,
    this.teacher,
    this.parentId,
    this.parent,
    this.enrollments,
  });

  factory ApplicationUser.fromJson(Map<String, dynamic> json) => ApplicationUser(
    id: json["id"],
    userName: json["userName"],
    lastName: json["lastName"],
    firstName: json["firstName"],
    yearOfBirth: json["yearOfBirth"],
    email: json["email"],
    isDeleted: json["isDeleted"],
    studentId: json["studentId"],
    student: json["student"],
    teacherId: json["teacherId"],
    teacher: json["teacher"],
    parentId: json["parentId"],
    parent: json["parent"],
    enrollments: json["enrollments"] == null ? [] : List<Enrollment>.from(json["enrollments"]!.map((x) => Enrollment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "lastName": lastName,
    "firstName": firstName,
    "yearOfBirth": yearOfBirth,
    "email": email,
    "isDeleted": isDeleted,
    "studentId": studentId,
    "student": student,
    "teacherId": teacherId,
    "teacher": teacher,
    "parentId": parentId,
    "parent": parent,
    "enrollments": enrollments == null ? [] : List<dynamic>.from(enrollments!.map((x) => x.toJson())),
  };
}

class Enrollment {
  String? applicationUserId;
  ApplicationUser? applicationUser;
  String? courseId;
  dynamic course;
  int? status;
  DateTime? created;
  String? id;
  bool? isDeleted;
  List<dynamic>? participants;
  List<WorksheetAttempt>? worksheetAttempts;

  Enrollment({
    this.applicationUserId,
    this.applicationUser,
    this.courseId,
    this.course,
    this.status,
    this.created,
    this.id,
    this.isDeleted,
    this.participants,
    this.worksheetAttempts,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) => Enrollment(
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"] == null ? null : ApplicationUser.fromJson(json["applicationUser"]),
    courseId: json["courseId"],
    course: json["course"],
    status: json["status"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    id: json["id"],
    isDeleted: json["isDeleted"],
    participants: json["participants"] == null ? [] : List<dynamic>.from(json["participants"]!.map((x) => x)),
    worksheetAttempts: json["worksheetAttempts"] == null ? [] : List<WorksheetAttempt>.from(json["worksheetAttempts"]!.map((x) => WorksheetAttempt.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "applicationUserId": applicationUserId,
    "applicationUser": applicationUser?.toJson(),
    "courseId": courseId,
    "course": course,
    "status": status,
    "created": created?.toIso8601String(),
    "id": id,
    "isDeleted": isDeleted,
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x)),
    "worksheetAttempts": worksheetAttempts == null ? [] : List<dynamic>.from(worksheetAttempts!.map((x) => x.toJson())),
  };
}

class Worksheet {
  String? title;
  String? description;
  String? worksheetTemplateId;
  dynamic worksheetTemplate;
  List<dynamic>? worksheetQuestions;
  DateTime? created;
  String? id;
  bool? isDeleted;

  Worksheet({
    this.title,
    this.description,
    this.worksheetTemplateId,
    this.worksheetTemplate,
    this.worksheetQuestions,
    this.created,
    this.id,
    this.isDeleted,
  });

  factory Worksheet.fromJson(Map<String, dynamic> json) => Worksheet(
    title: json["title"],
    description: json["description"],
    worksheetTemplateId: json["worksheetTemplateId"],
    worksheetTemplate: json["worksheetTemplate"],
    worksheetQuestions: json["worksheetQuestions"] == null ? [] : List<dynamic>.from(json["worksheetQuestions"]!.map((x) => x)),
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "worksheetTemplateId": worksheetTemplateId,
    "worksheetTemplate": worksheetTemplate,
    "worksheetQuestions": worksheetQuestions == null ? [] : List<dynamic>.from(worksheetQuestions!.map((x) => x)),
    "created": created?.toIso8601String(),
    "id": id,
    "isDeleted": isDeleted,
  };
}
