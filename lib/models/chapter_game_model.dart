// To parse this JSON data, do
//
//     final chapterGameModel = chapterGameModelFromJson(jsonString);

import 'dart:convert';

ChapterGameModel chapterGameModelFromJson(String str) => ChapterGameModel.fromJson(json.decode(str));

String chapterGameModelToJson(ChapterGameModel data) => json.encode(data.toJson());

class ChapterGameModel {
  String? message;
  bool? success;
  int? code;
  ChapterGameData? data;
  dynamic errors;
  dynamic fieldErrors;

  ChapterGameModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory ChapterGameModel.fromJson(Map<String, dynamic> json) => ChapterGameModel(
    message: json["message"],
    success: json["success"],
    code: json["code"],
    data: json["data"] == null ? null : ChapterGameData.fromJson(json["data"]),
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

class ChapterGameData {
  List<ChapterGameItem>? items;
  int? pageIndex;
  int? pageSize;
  int? totalPage;

  ChapterGameData({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalPage,
  });

  factory ChapterGameData.fromJson(Map<String, dynamic> json) => ChapterGameData(
    items: json["items"] == null ? [] : List<ChapterGameItem>.from(json["items"]!.map((x) => ChapterGameItem.fromJson(x))),
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

class ChapterGameItem {
  String? chapterId;
  String? gameId;
  DateTime? created;
  String? id;
  bool? isDeleted;

  ChapterGameItem({
    this.chapterId,
    this.gameId,
    this.created,
    this.id,
    this.isDeleted,
  });

  factory ChapterGameItem.fromJson(Map<String, dynamic> json) => ChapterGameItem(
    chapterId: json["chapterId"],
    gameId: json["gameId"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "chapterId": chapterId,
    "gameId": gameId,
    "created": created?.toIso8601String(),
    "id": id,
    "isDeleted": isDeleted,
  };
}
