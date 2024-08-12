// To parse this JSON data, do
//
//     final enrollmentModel = enrollmentModelFromJson(jsonString);

import 'dart:convert';

EnrollmentModel enrollmentModelFromJson(String str) => EnrollmentModel.fromJson(json.decode(str));

String enrollmentModelToJson(EnrollmentModel data) => json.encode(data.toJson());

class EnrollmentModel {
  String? message;
  bool? success;
  int? code;
  Data? data;
  dynamic errors;
  dynamic fieldErrors;

  EnrollmentModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) => EnrollmentModel(
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
  List<EnrollmentModelItem>? items;
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
    items: json["items"] == null ? [] : List<EnrollmentModelItem>.from(json["items"]!.map((x) => EnrollmentModelItem.fromJson(x))),
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

class CourseLevel {
  String? title;
  String? description;
  String? id;
  bool? isDeleted;
  List<Course?>? courses;

  CourseLevel({
    this.title,
    this.description,
    this.id,
    this.isDeleted,
    this.courses,
  });

  factory CourseLevel.fromJson(Map<String, dynamic> json) => CourseLevel(
    title: json["title"],
    description: json["description"],
    id: json["id"],
    isDeleted: json["isDeleted"],
    courses: json["courses"] == null ? [] : List<Course?>.from(json["courses"]!.map((x) => x == null ? null : Course.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "id": id,
    "isDeleted": isDeleted,
    "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x?.toJson())),
  };
}

class Course {
  String? title;
  String? imageUrl;
  String? description;
  int? price;
  int? totalSlot;
  String? subjectId;
  CourseLevel? subject;
  String? programTypeId;
  CourseLevel? programType;
  String? courseLevelId;
  CourseLevel? courseLevel;
  List<dynamic>? teachables;
  List<dynamic>? chapters;
  List<EnrollmentModelItem>? enrollments;
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
    this.enrollments,
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
    subject: json["subject"] == null ? null : CourseLevel.fromJson(json["subject"]),
    programTypeId: json["programTypeId"],
    programType: json["programType"] == null ? null : CourseLevel.fromJson(json["programType"]),
    courseLevelId: json["courseLevelId"],
    courseLevel: json["courseLevel"] == null ? null : CourseLevel.fromJson(json["courseLevel"]),
    teachables: json["teachables"] == null ? [] : List<dynamic>.from(json["teachables"]!.map((x) => x)),
    chapters: json["chapters"] == null ? [] : List<dynamic>.from(json["chapters"]!.map((x) => x)),
    enrollments: json["enrollments"] == null ? [] : List<EnrollmentModelItem>.from(json["enrollments"]!.map((x) => EnrollmentModelItem.fromJson(x))),
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
    "subject": subject?.toJson(),
    "programTypeId": programTypeId,
    "programType": programType?.toJson(),
    "courseLevelId": courseLevelId,
    "courseLevel": courseLevel?.toJson(),
    "teachables": teachables == null ? [] : List<dynamic>.from(teachables!.map((x) => x)),
    "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x)),
    "enrollments": enrollments == null ? [] : List<dynamic>.from(enrollments!.map((x) => x.toJson())),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class EnrollmentModelItem {
  String? applicationUserId;
  ApplicationUser? applicationUser;
  String? courseId;
  Course? course;
  int? status;
  String? id;
  bool? isDeleted;

  EnrollmentModelItem({
    this.applicationUserId,
    this.applicationUser,
    this.courseId,
    this.course,
    this.status,
    this.id,
    this.isDeleted,
  });

  factory EnrollmentModelItem.fromJson(Map<String, dynamic> json) => EnrollmentModelItem(
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"] == null ? null : ApplicationUser.fromJson(json["applicationUser"]),
    courseId: json["courseId"],
    course: json["course"] == null ? null : Course.fromJson(json["course"]),
    status: json["status"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "applicationUserId": applicationUserId,
    "applicationUser": applicationUser?.toJson(),
    "courseId": courseId,
    "course": course?.toJson(),
    "status": status,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class ApplicationUser {
  String? id;
  String? userName;
  dynamic lastName;
  dynamic firstName;
  String? email;
  bool? isDeleted;
  String? studentId;
  Student? student;
  dynamic teacherId;
  dynamic teacher;
  dynamic parentId;
  dynamic parent;

  ApplicationUser({
    this.id,
    this.userName,
    this.lastName,
    this.firstName,
    this.email,
    this.isDeleted,
    this.studentId,
    this.student,
    this.teacherId,
    this.teacher,
    this.parentId,
    this.parent,
  });

  factory ApplicationUser.fromJson(Map<String, dynamic> json) => ApplicationUser(
    id: json["id"],
    userName: json["userName"],
    lastName: json["lastName"],
    firstName: json["firstName"],
    email: json["email"],
    isDeleted: json["isDeleted"],
    studentId: json["studentId"],
    student: json["student"] == null ? null : Student.fromJson(json["student"]),
    teacherId: json["teacherId"],
    teacher: json["teacher"],
    parentId: json["parentId"],
    parent: json["parent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "lastName": lastName,
    "firstName": firstName,
    "email": email,
    "isDeleted": isDeleted,
    "studentId": studentId,
    "student": student?.toJson(),
    "teacherId": teacherId,
    "teacher": teacher,
    "parentId": parentId,
    "parent": parent,
  };
}

class Student {
  String? applicationUserId;
  int? image;
  String? school;
  String? studentClass;
  String? id;
  bool? isDeleted;

  Student({
    this.applicationUserId,
    this.image,
    this.school,
    this.studentClass,
    this.id,
    this.isDeleted,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    applicationUserId: json["applicationUserId"],
    image: json["image"],
    school: json["school"],
    studentClass: json["class"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "applicationUserId": applicationUserId,
    "image": image,
    "school": school,
    "class": studentClass,
    "id": id,
    "isDeleted": isDeleted,
  };
}
