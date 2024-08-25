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
  ChapterGameModelData? data;
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
    data: json["data"] == null ? null : ChapterGameModelData.fromJson(json["data"]),
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

class ChapterGameModelData {
  List<ChapterGameModelItem>? items;
  int? pageIndex;
  int? pageSize;
  int? totalPage;

  ChapterGameModelData({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalPage,
  });

  factory ChapterGameModelData.fromJson(Map<String, dynamic> json) => ChapterGameModelData(
    items: json["items"] == null ? [] : List<ChapterGameModelItem>.from(json["items"]!.map((x) => ChapterGameModelItem.fromJson(x))),
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

class ChapterGameModelItem {
  String? chapterId;
  dynamic chapter;
  String? gameId;
  Game? game;
  DateTime? created;
  String? id;
  bool? isDeleted;

  ChapterGameModelItem({
    this.chapterId,
    this.chapter,
    this.gameId,
    this.game,
    this.created,
    this.id,
    this.isDeleted,
  });

  factory ChapterGameModelItem.fromJson(Map<String, dynamic> json) => ChapterGameModelItem(
    chapterId: json["chapterId"],
    chapter: json["chapter"],
    gameId: json["gameId"],
    game: json["game"] == null ? null : Game.fromJson(json["game"]),
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "chapterId": chapterId,
    "chapter": chapter,
    "gameId": gameId,
    "game": game?.toJson(),
    "created": created?.toIso8601String(),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Game {
  String? name;
  String? description;
  String? image;
  String? itemStoreJson;
  String? animalJson;
  DateTime? created;
  String? id;
  bool? isDeleted;

  Game({
    this.name,
    this.description,
    this.image,
    this.itemStoreJson,
    this.animalJson,
    this.created,
    this.id,
    this.isDeleted,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    name: json["name"],
    description: json["description"],
    image: json["image"],
    itemStoreJson: json["itemStoreJson"],
    animalJson: json["animalJson"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "image": image,
    "itemStoreJson": itemStoreJson,
    "animalJson": animalJson,
    "created": created?.toIso8601String(),
    "id": id,
    "isDeleted": isDeleted,
  };
}
