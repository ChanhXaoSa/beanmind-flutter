// To parse this JSON data, do
//
//     final participantModel = participantModelFromJson(jsonString);

import 'dart:convert';

ParticipantModel participantModelFromJson(String str) => ParticipantModel.fromJson(json.decode(str));

String participantModelToJson(ParticipantModel data) => json.encode(data.toJson());

class ParticipantModel {
  String? message;
  bool? success;
  int? code;
  ParticipantModelData? data;
  dynamic errors;
  dynamic fieldErrors;

  ParticipantModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) => ParticipantModel(
    message: json["message"],
    success: json["success"],
    code: json["code"],
    data: json["data"] == null ? null : ParticipantModelData.fromJson(json["data"]),
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

class ParticipantModelData {
  List<ParticipantModelItem>? items;
  int? pageIndex;
  int? pageSize;
  int? totalPage;

  ParticipantModelData({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalPage,
  });

  factory ParticipantModelData.fromJson(Map<String, dynamic> json) => ParticipantModelData(
    items: json["items"] == null ? [] : List<ParticipantModelItem>.from(json["items"]!.map((x) => ParticipantModelItem.fromJson(x))),
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

class TeachingSlot {
  int? dayInWeek;
  int? dayIndex;
  String? startTime;
  String? endTime;
  String? courseId;
  Course? course;
  String? id;
  bool? isDeleted;

  TeachingSlot({
    this.dayInWeek,
    this.dayIndex,
    this.startTime,
    this.endTime,
    this.courseId,
    this.course,
    this.id,
    this.isDeleted,
  });

  factory TeachingSlot.fromJson(Map<String, dynamic> json) => TeachingSlot(
    dayInWeek: json["dayInWeek"],
    dayIndex: json["dayIndex"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    courseId: json["courseId"],
    course: json["course"] == null ? null : Course.fromJson(json["course"]),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "dayInWeek": dayInWeek,
    "dayIndex": dayIndex,
    "startTime": startTime,
    "endTime": endTime,
    "courseId": courseId,
    "course": course?.toJson(),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Session {
  DateTime? date;
  String? applicationUserId;
  ApplicationUser? applicationUser;
  String? teachingSlotId;
  TeachingSlot? teachingSlot;
  List<dynamic>? participants;
  String? id;
  bool? isDeleted;

  Session({
    this.date,
    this.applicationUserId,
    this.applicationUser,
    this.teachingSlotId,
    this.teachingSlot,
    this.participants,
    this.id,
    this.isDeleted,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"] == null ? null : ApplicationUser.fromJson(json["applicationUser"]),
    teachingSlotId: json["teachingSlotId"],
    teachingSlot: json["teachingSlot"] == null ? null : TeachingSlot.fromJson(json["teachingSlot"]),
    participants: json["participants"] == null ? [] : List<dynamic>.from(json["participants"]!.map((x) => x)),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String(),
    "applicationUserId": applicationUserId,
    "applicationUser": applicationUser?.toJson(),
    "teachingSlotId": teachingSlotId,
    "teachingSlot": teachingSlot?.toJson(),
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x)),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Course {
  String? title;
  String? imageUrl;
  String? description;
  int? price;
  int? totalSlot;
  String? subjectId;
  dynamic subject;
  String? programTypeId;
  dynamic programType;
  String? courseLevelId;
  dynamic courseLevel;
  List<dynamic>? teachables;
  List<dynamic>? chapters;
  List<ItemEnrollment>? enrollments;
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
    subject: json["subject"],
    programTypeId: json["programTypeId"],
    programType: json["programType"],
    courseLevelId: json["courseLevelId"],
    courseLevel: json["courseLevel"],
    teachables: json["teachables"] == null ? [] : List<dynamic>.from(json["teachables"]!.map((x) => x)),
    chapters: json["chapters"] == null ? [] : List<dynamic>.from(json["chapters"]!.map((x) => x)),
    enrollments: json["enrollments"] == null ? [] : List<ItemEnrollment>.from(json["enrollments"]!.map((x) => ItemEnrollment.fromJson(x))),
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
    "subject": subject,
    "programTypeId": programTypeId,
    "programType": programType,
    "courseLevelId": courseLevelId,
    "courseLevel": courseLevel,
    "teachables": teachables == null ? [] : List<dynamic>.from(teachables!.map((x) => x)),
    "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x)),
    "enrollments": enrollments == null ? [] : List<dynamic>.from(enrollments!.map((x) => x.toJson())),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class ApplicationUserEnrollment {
  String? applicationUserId;
  dynamic applicationUser;
  String? courseId;
  Course? course;
  List<ParticipantModelItem?>? participants;
  List<dynamic>? worksheetAttempts;
  int? status;
  int? percentTopicCompletion;
  int? percentWorksheetCompletion;
  String? id;
  bool? isDeleted;

  ApplicationUserEnrollment({
    this.applicationUserId,
    this.applicationUser,
    this.courseId,
    this.course,
    this.participants,
    this.worksheetAttempts,
    this.status,
    this.percentTopicCompletion,
    this.percentWorksheetCompletion,
    this.id,
    this.isDeleted,
  });

  factory ApplicationUserEnrollment.fromJson(Map<String, dynamic> json) => ApplicationUserEnrollment(
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"],
    courseId: json["courseId"],
    course: json["course"] == null ? null : Course.fromJson(json["course"]),
    participants: json["participants"] == null ? [] : List<ParticipantModelItem?>.from(json["participants"]!.map((x) => x == null ? null : ParticipantModelItem.fromJson(x))),
    worksheetAttempts: json["worksheetAttempts"] == null ? [] : List<dynamic>.from(json["worksheetAttempts"]!.map((x) => x)),
    status: json["status"],
    percentTopicCompletion: json["percentTopicCompletion"],
    percentWorksheetCompletion: json["percentWorksheetCompletion"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "applicationUserId": applicationUserId,
    "applicationUser": applicationUser,
    "courseId": courseId,
    "course": course?.toJson(),
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x?.toJson())),
    "worksheetAttempts": worksheetAttempts == null ? [] : List<dynamic>.from(worksheetAttempts!.map((x) => x)),
    "status": status,
    "percentTopicCompletion": percentTopicCompletion,
    "percentWorksheetCompletion": percentWorksheetCompletion,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class ApplicationUser {
  String? id;
  String? userName;
  String? lastName;
  String? firstName;
  String? email;
  bool? isDeleted;
  String? studentId;
  Student? student;
  String? teacherId;
  dynamic teacher;
  dynamic parentId;
  dynamic parent;
  List<ApplicationUserEnrollment>? enrollments;

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
    this.enrollments,
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
    enrollments: json["enrollments"] == null ? [] : List<ApplicationUserEnrollment>.from(json["enrollments"]!.map((x) => ApplicationUserEnrollment.fromJson(x))),
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
    "enrollments": enrollments == null ? [] : List<dynamic>.from(enrollments!.map((x) => x.toJson())),
  };
}

class ItemEnrollment {
  String? applicationUserId;
  ApplicationUser? applicationUser;
  String? courseId;
  Course? course;
  int? status;
  int? percentTopicCompletion;
  int? percentWorksheetCompletion;
  String? id;
  bool? isDeleted;

  ItemEnrollment({
    this.applicationUserId,
    this.applicationUser,
    this.courseId,
    this.course,
    this.status,
    this.percentTopicCompletion,
    this.percentWorksheetCompletion,
    this.id,
    this.isDeleted,
  });

  factory ItemEnrollment.fromJson(Map<String, dynamic> json) => ItemEnrollment(
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"] == null ? null : ApplicationUser.fromJson(json["applicationUser"]),
    courseId: json["courseId"],
    course: json["course"] == null ? null : Course.fromJson(json["course"]),
    status: json["status"],
    percentTopicCompletion: json["percentTopicCompletion"],
    percentWorksheetCompletion: json["percentWorksheetCompletion"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "applicationUserId": applicationUserId,
    "applicationUser": applicationUser?.toJson(),
    "courseId": courseId,
    "course": course?.toJson(),
    "status": status,
    "percentTopicCompletion": percentTopicCompletion,
    "percentWorksheetCompletion": percentWorksheetCompletion,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class ParticipantModelItem {
  String? enrollmentId;
  ItemEnrollment? enrollment;
  String? sessionId;
  Session? session;
  bool? isPresent;
  int? status;
  String? id;
  bool? isDeleted;

  ParticipantModelItem({
    this.enrollmentId,
    this.enrollment,
    this.sessionId,
    this.session,
    this.isPresent,
    this.status,
    this.id,
    this.isDeleted,
  });

  factory ParticipantModelItem.fromJson(Map<String, dynamic> json) => ParticipantModelItem(
    enrollmentId: json["enrollmentId"],
    enrollment: json["enrollment"] == null ? null : ItemEnrollment.fromJson(json["enrollment"]),
    sessionId: json["sessionId"],
    session: json["session"] == null ? null : Session.fromJson(json["session"]),
    isPresent: json["isPresent"],
    status: json["status"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "enrollmentId": enrollmentId,
    "enrollment": enrollment?.toJson(),
    "sessionId": sessionId,
    "session": session?.toJson(),
    "isPresent": isPresent,
    "status": status,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Student {
  String? applicationUserId;
  dynamic applicationUser;
  String? image;
  String? school;
  String? studentClass;
  String? id;
  bool? isDeleted;

  Student({
    this.applicationUserId,
    this.applicationUser,
    this.image,
    this.school,
    this.studentClass,
    this.id,
    this.isDeleted,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"],
    image: json["image"],
    school: json["school"],
    studentClass: json["class"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "applicationUserId": applicationUserId,
    "applicationUser": applicationUser,
    "image": image,
    "school": school,
    "class": studentClass,
    "id": id,
    "isDeleted": isDeleted,
  };
}
