// To parse this JSON data, do
//
//     final courseDetailModel = courseDetailModelFromJson(jsonString);

import 'dart:convert';

CourseDetailModel courseDetailModelFromJson(String str) => CourseDetailModel.fromJson(json.decode(str));

String courseDetailModelToJson(CourseDetailModel data) => json.encode(data.toJson());

class CourseDetailModel {
  String? message;
  bool? success;
  int? code;
  CourseDetailData? data;
  dynamic errors;
  dynamic fieldErrors;

  CourseDetailModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) => CourseDetailModel(
    message: json["message"],
    success: json["success"],
    code: json["code"],
    data: json["data"] == null ? null : CourseDetailData.fromJson(json["data"]),
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

class CourseDetailData {
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
  List<TeachingSlot>? teachingSlots;
  List<Teachable>? teachables;
  List<Chapter>? chapters;
  List<Enrollment>? enrollments;
  List<WorksheetTemplate>? worksheetTemplates;
  String? id;
  bool? isDeleted;

  CourseDetailData({
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
    this.teachingSlots,
    this.teachables,
    this.chapters,
    this.enrollments,
    this.worksheetTemplates,
    this.id,
    this.isDeleted,
  });

  factory CourseDetailData.fromJson(Map<String, dynamic> json) => CourseDetailData(
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
    teachingSlots: json["teachingSlots"] == null ? [] : List<TeachingSlot>.from(json["teachingSlots"]!.map((x) => TeachingSlot.fromJson(x))),
    teachables: json["teachables"] == null ? [] : List<Teachable>.from(json["teachables"]!.map((x) => Teachable.fromJson(x))),
    chapters: json["chapters"] == null ? [] : List<Chapter>.from(json["chapters"]!.map((x) => Chapter.fromJson(x))),
    enrollments: json["enrollments"] == null ? [] : List<Enrollment>.from(json["enrollments"]!.map((x) => Enrollment.fromJson(x))),
    worksheetTemplates: json["worksheetTemplates"] == null ? [] : List<WorksheetTemplate>.from(json["worksheetTemplates"]!.map((x) => WorksheetTemplate.fromJson(x))),
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
    "teachingSlots": teachingSlots == null ? [] : List<dynamic>.from(teachingSlots!.map((x) => x.toJson())),
    "teachables": teachables == null ? [] : List<dynamic>.from(teachables!.map((x) => x.toJson())),
    "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x.toJson())),
    "enrollments": enrollments == null ? [] : List<dynamic>.from(enrollments!.map((x) => x.toJson())),
    "worksheetTemplates": worksheetTemplates == null ? [] : List<dynamic>.from(worksheetTemplates!.map((x) => x.toJson())),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Teachable {
  String? applicationUserId;
  ApplicationUser? applicationUser;
  String? courseId;
  bool? status;
  String? id;
  bool? isDeleted;
  CourseLevelCourse? course;

  Teachable({
    this.applicationUserId,
    this.applicationUser,
    this.courseId,
    this.status,
    this.id,
    this.isDeleted,
    this.course,
  });

  factory Teachable.fromJson(Map<String, dynamic> json) => Teachable(
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"] == null ? null : ApplicationUser.fromJson(json["applicationUser"]),
    courseId: json["courseId"],
    status: json["status"],
    id: json["id"],
    isDeleted: json["isDeleted"],
    course: json["course"] == null ? null : CourseLevelCourse.fromJson(json["course"]),
  );

  Map<String, dynamic> toJson() => {
    "applicationUserId": applicationUserId,
    "applicationUser": applicationUser?.toJson(),
    "courseId": courseId,
    "status": status,
    "id": id,
    "isDeleted": isDeleted,
    "course": course?.toJson(),
  };
}

class CourseLevelCourse {
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
  List<Teachable>? teachables;
  List<Chapter>? chapters;
  String? id;
  bool? isDeleted;

  CourseLevelCourse({
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
    this.id,
    this.isDeleted,
  });

  factory CourseLevelCourse.fromJson(Map<String, dynamic> json) => CourseLevelCourse(
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
    teachables: json["teachables"] == null ? [] : List<Teachable>.from(json["teachables"]!.map((x) => Teachable.fromJson(x))),
    chapters: json["chapters"] == null ? [] : List<Chapter>.from(json["chapters"]!.map((x) => Chapter.fromJson(x))),
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
    "teachables": teachables == null ? [] : List<dynamic>.from(teachables!.map((x) => x.toJson())),
    "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x.toJson())),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class CourseLevel {
  String? title;
  String? description;
  String? id;
  bool? isDeleted;
  List<CourseLevelCourse?>? courses;

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
    courses: json["courses"] == null ? [] : List<CourseLevelCourse?>.from(json["courses"]!.map((x) => x == null ? null : CourseLevelCourse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "id": id,
    "isDeleted": isDeleted,
    "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x?.toJson())),
  };
}

class ChapterCourse {
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
  List<Teachable>? teachables;
  List<Chapter?>? chapters;
  String? id;
  bool? isDeleted;

  ChapterCourse({
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
    this.id,
    this.isDeleted,
  });

  factory ChapterCourse.fromJson(Map<String, dynamic> json) => ChapterCourse(
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
    teachables: json["teachables"] == null ? [] : List<Teachable>.from(json["teachables"]!.map((x) => Teachable.fromJson(x))),
    chapters: json["chapters"] == null ? [] : List<Chapter?>.from(json["chapters"]!.map((x) => x == null ? null : Chapter.fromJson(x))),
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
    "teachables": teachables == null ? [] : List<dynamic>.from(teachables!.map((x) => x.toJson())),
    "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x?.toJson())),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Chapter {
  String? title;
  String? description;
  int? order;
  String? courseId;
  ChapterCourse? course;
  List<dynamic>? topics;
  String? id;
  bool? isDeleted;

  Chapter({
    this.title,
    this.description,
    this.order,
    this.courseId,
    this.course,
    this.topics,
    this.id,
    this.isDeleted,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    title: json["title"],
    description: json["description"],
    order: json["order"],
    courseId: json["courseId"],
    course: json["course"] == null ? null : ChapterCourse.fromJson(json["course"]),
    topics: json["topics"] == null ? [] : List<dynamic>.from(json["topics"]!.map((x) => x)),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "order": order,
    "courseId": courseId,
    "course": course?.toJson(),
    "topics": topics == null ? [] : List<dynamic>.from(topics!.map((x) => x)),
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
  dynamic studentId;
  dynamic student;
  String? teacherId;
  dynamic teacher;
  dynamic parentId;
  dynamic parent;
  bool? isDeleted;

  ApplicationUser({
    this.id,
    this.userName,
    this.lastName,
    this.firstName,
    this.email,
    this.studentId,
    this.student,
    this.teacherId,
    this.teacher,
    this.parentId,
    this.parent,
    this.isDeleted,
  });

  factory ApplicationUser.fromJson(Map<String, dynamic> json) => ApplicationUser(
    id: json["id"],
    userName: json["userName"],
    lastName: json["lastName"],
    firstName: json["firstName"],
    email: json["email"],
    studentId: json["studentId"],
    student: json["student"],
    teacherId: json["teacherId"],
    teacher: json["teacher"],
    parentId: json["parentId"],
    parent: json["parent"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "lastName": lastName,
    "firstName": firstName,
    "email": email,
    "studentId": studentId,
    "student": student,
    "teacherId": teacherId,
    "teacher": teacher,
    "parentId": parentId,
    "parent": parent,
    "isDeleted": isDeleted,
  };
}

class Enrollment {
  String? applicationUserId;
  dynamic applicationUser;
  String? courseId;
  CourseLevelCourse? course;
  int? status;
  String? id;
  bool? isDeleted;

  Enrollment({
    this.applicationUserId,
    this.applicationUser,
    this.courseId,
    this.course,
    this.status,
    this.id,
    this.isDeleted,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) => Enrollment(
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"],
    courseId: json["courseId"],
    course: json["course"] == null ? null : CourseLevelCourse.fromJson(json["course"]),
    status: json["status"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "applicationUserId": applicationUserId,
    "applicationUser": applicationUser,
    "courseId": courseId,
    "course": course?.toJson(),
    "status": status,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class TeachingSlot {
  String? title;
  int? dayInWeek;
  int? slot;
  String? courseId;
  CourseLevelCourse? course;
  String? id;
  bool? isDeleted;

  TeachingSlot({
    this.title,
    this.dayInWeek,
    this.slot,
    this.courseId,
    this.course,
    this.id,
    this.isDeleted,
  });

  factory TeachingSlot.fromJson(Map<String, dynamic> json) => TeachingSlot(
    title: json["title"],
    dayInWeek: json["dayInWeek"],
    slot: json["slot"],
    courseId: json["courseId"],
    course: json["course"] == null ? null : CourseLevelCourse.fromJson(json["course"]),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "dayInWeek": dayInWeek,
    "slot": slot,
    "courseId": courseId,
    "course": course?.toJson(),
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
