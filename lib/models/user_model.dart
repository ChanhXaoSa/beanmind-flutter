// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String message;
  bool success;
  Data data;
  dynamic errors;
  dynamic fieldErrors;

  UserModel({
    required this.message,
    required this.success,
    required this.data,
    required this.errors,
    required this.fieldErrors,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    message: json["message"],
    success: json["success"],
    data: Data.fromJson(json["data"]),
    errors: json["errors"],
    fieldErrors: json["fieldErrors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": data.toJson(),
    "errors": errors,
    "fieldErrors": fieldErrors,
  };
}

class Data {
  String id;
  String userName;
  dynamic phoneNumber;
  String email;
  bool emailConfirmed;
  // bool isDeleted;
  List<String> roles;
  // List<dynamic> teachables;
  // List<dynamic> enrollments;
  // List<dynamic> teachingSlots;
  // List<dynamic> sessions;
  // List<dynamic> worksheets;

  Data({
    required this.id,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.emailConfirmed,
    // required this.isDeleted,
    required this.roles,
    // required this.teachables,
    // required this.enrollments,
    // required this.teachingSlots,
    // required this.sessions,
    // required this.worksheets,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userName: json["userName"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    emailConfirmed: json["emailConfirmed"],
    // isDeleted: json["isDeleted"],
    roles: List<String>.from(json["roles"].map((x) => x)),
    // teachables: List<dynamic>.from(json["teachables"].map((x) => x)),
    // enrollments: List<dynamic>.from(json["enrollments"].map((x) => x)),
    // teachingSlots: List<dynamic>.from(json["teachingSlots"].map((x) => x)),
    // sessions: List<dynamic>.from(json["sessions"].map((x) => x)),
    // worksheets: List<dynamic>.from(json["worksheets"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "phoneNumber": phoneNumber,
    "email": email,
    "emailConfirmed": emailConfirmed,
    // "isDeleted": isDeleted,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    // "teachables": List<dynamic>.from(teachables.map((x) => x)),
    // "enrollments": List<dynamic>.from(enrollments.map((x) => x)),
    // "teachingSlots": List<dynamic>.from(teachingSlots.map((x) => x)),
    // "sessions": List<dynamic>.from(sessions.map((x) => x)),
    // "worksheets": List<dynamic>.from(worksheets.map((x) => x)),
  };
}
