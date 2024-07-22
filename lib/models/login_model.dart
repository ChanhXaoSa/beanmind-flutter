// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String message;
  bool success;
  Data? data;
  dynamic errors;
  dynamic fieldErrors;

  LoginModel({
    required this.message,
    required this.success,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    message: json["message"] ?? '',
    success: json["success"] ?? false,
    data: json["data"] != null ? Data.fromJson(json["data"]) : null,
    errors: json["errors"],
    fieldErrors: json["fieldErrors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": data?.toJson(),
    "errors": errors,
    "fieldErrors": fieldErrors,
  };
}

class Data {
  String tokenType;
  String accessToken;
  int expiresIn;
  String refreshToken;

  Data({
    required this.tokenType,
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tokenType: json["tokenType"] ?? '',
    accessToken: json["accessToken"] ?? '',
    expiresIn: json["expiresIn"] ?? 0,
    refreshToken: json["refreshToken"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "tokenType": tokenType,
    "accessToken": accessToken,
    "expiresIn": expiresIn,
    "refreshToken": refreshToken,
  };
}
