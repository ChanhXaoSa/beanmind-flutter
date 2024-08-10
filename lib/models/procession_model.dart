// To parse this JSON data, do
//
//     final processionModel = processionModelFromJson(jsonString);

import 'dart:convert';

ProcessionModel processionModelFromJson(String str) => ProcessionModel.fromJson(json.decode(str));

String processionModelToJson(ProcessionModel data) => json.encode(data.toJson());

class ProcessionModel {
  String? message;
  bool? success;
  int? code;
  Data? data;
  dynamic errors;
  dynamic fieldErrors;

  ProcessionModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory ProcessionModel.fromJson(Map<String, dynamic> json) => ProcessionModel(
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
  String? participantId;
  Participant? participant;
  String? topicId;
  Topic? topic;
  String? id;
  bool? isDeleted;

  Item({
    this.participantId,
    this.participant,
    this.topicId,
    this.topic,
    this.id,
    this.isDeleted,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    participantId: json["participantId"],
    participant: json["participant"] == null ? null : Participant.fromJson(json["participant"]),
    topicId: json["topicId"],
    topic: json["topic"] == null ? null : Topic.fromJson(json["topic"]),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "participantId": participantId,
    "participant": participant?.toJson(),
    "topicId": topicId,
    "topic": topic?.toJson(),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Participant {
  String? enrollmentId;
  dynamic enrollment;
  String? sessionId;
  dynamic session;
  bool? isPresent;
  int? status;
  String? id;
  bool? isDeleted;

  Participant({
    this.enrollmentId,
    this.enrollment,
    this.sessionId,
    this.session,
    this.isPresent,
    this.status,
    this.id,
    this.isDeleted,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    enrollmentId: json["enrollmentId"],
    enrollment: json["enrollment"],
    sessionId: json["sessionId"],
    session: json["session"],
    isPresent: json["isPresent"],
    status: json["status"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "enrollmentId": enrollmentId,
    "enrollment": enrollment,
    "sessionId": sessionId,
    "session": session,
    "isPresent": isPresent,
    "status": status,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Topic {
  String? title;
  String? description;
  dynamic order;
  String? chapterId;
  dynamic chapter;
  List<dynamic>? processions;
  String? id;
  bool? isDeleted;

  Topic({
    this.title,
    this.description,
    this.order,
    this.chapterId,
    this.chapter,
    this.processions,
    this.id,
    this.isDeleted,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    title: json["title"],
    description: json["description"],
    order: json["order"],
    chapterId: json["chapterId"],
    chapter: json["chapter"],
    processions: json["processions"] == null ? [] : List<dynamic>.from(json["processions"]!.map((x) => x)),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "order": order,
    "chapterId": chapterId,
    "chapter": chapter,
    "processions": processions == null ? [] : List<dynamic>.from(processions!.map((x) => x)),
    "id": id,
    "isDeleted": isDeleted,
  };
}
