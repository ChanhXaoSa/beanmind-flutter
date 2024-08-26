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
  String? contentURL;
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
    this.contentURL,
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
    contentURL : json["contentURL"],
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
    "contentURL" : contentURL,
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
  CourseLevelCourse? course;
  String? id;
  bool? isDeleted;

  Teachable({
    this.applicationUserId,
    this.applicationUser,
    this.courseId,
    this.course,
    this.id,
    this.isDeleted,
  });

  factory Teachable.fromJson(Map<String, dynamic> json) => Teachable(
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"] == null ? null : ApplicationUser.fromJson(json["applicationUser"]),
    courseId: json["courseId"],
    course: json["course"] == null ? null : CourseLevelCourse.fromJson(json["course"]),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "applicationUserId": applicationUserId,
    "applicationUser": applicationUser?.toJson(),
    "courseId": courseId,
    "course": course?.toJson(),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Enrollment {
  String? applicationUserId;
  dynamic applicationUser;
  String? courseId;
  CourseLevelCourse? course;
  int? status;
  int? percentTopicCompletion;
  int? percentWorksheetCompletion;
  String? id;
  bool? isDeleted;

  Enrollment({
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

  factory Enrollment.fromJson(Map<String, dynamic> json) => Enrollment(
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"],
    courseId: json["courseId"],
    course: json["course"] == null ? null : CourseLevelCourse.fromJson(json["course"]),
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
    "status": status,
    "percentTopicCompletion": percentTopicCompletion,
    "percentWorksheetCompletion": percentWorksheetCompletion,
    "id": id,
    "isDeleted": isDeleted,
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
  List<Enrollment>? enrollments;
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
    this.enrollments,
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
    enrollments: json["enrollments"] == null ? [] : List<Enrollment>.from(json["enrollments"]!.map((x) => Enrollment.fromJson(x))),
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
    "enrollments": enrollments == null ? [] : List<dynamic>.from(enrollments!.map((x) => x.toJson())),
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
  List<Enrollment>? enrollments;
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
    this.enrollments,
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
    enrollments: json["enrollments"] == null ? [] : List<Enrollment>.from(json["enrollments"]!.map((x) => Enrollment.fromJson(x))),
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
    "enrollments": enrollments == null ? [] : List<dynamic>.from(enrollments!.map((x) => x.toJson())),
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
  List<Topic>? topics;
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
    topics: json["topics"] == null ? [] : List<Topic>.from(json["topics"]!.map((x) => Topic.fromJson(x))),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "order": order,
    "courseId": courseId,
    "course": course?.toJson(),
    "topics": topics == null ? [] : List<dynamic>.from(topics!.map((x) => x.toJson())),
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
  dynamic studentId;
  dynamic student;
  String? teacherId;
  dynamic teacher;
  dynamic parentId;
  dynamic parent;
  List<dynamic>? enrollments;

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
    student: json["student"],
    teacherId: json["teacherId"],
    teacher: json["teacher"],
    parentId: json["parentId"],
    parent: json["parent"],
    enrollments: json["enrollments"] == null ? [] : List<dynamic>.from(json["enrollments"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "lastName": lastName,
    "firstName": firstName,
    "email": email,
    "isDeleted": isDeleted,
    "studentId": studentId,
    "student": student,
    "teacherId": teacherId,
    "teacher": teacher,
    "parentId": parentId,
    "parent": parent,
    "enrollments": enrollments == null ? [] : List<dynamic>.from(enrollments!.map((x) => x)),
  };
}

class Topic {
  String? title;
  String? description;
  int? order;
  String? chapterId;
  dynamic chapter;
  List<dynamic>? questions;
  List<dynamic>? worksheetTemplates;
  List<dynamic>? processions;
  String? id;
  bool? isDeleted;

  Topic({
    this.title,
    this.description,
    this.order,
    this.chapterId,
    this.chapter,
    this.questions,
    this.worksheetTemplates,
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
    questions: json["questions"] == null ? [] : List<dynamic>.from(json["questions"]!.map((x) => x)),
    worksheetTemplates: json["worksheetTemplates"] == null ? [] : List<dynamic>.from(json["worksheetTemplates"]!.map((x) => x)),
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
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x)),
    "worksheetTemplates": worksheetTemplates == null ? [] : List<dynamic>.from(worksheetTemplates!.map((x) => x)),
    "processions": processions == null ? [] : List<dynamic>.from(processions!.map((x) => x)),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class TeachingSlot {
  int? dayInWeek;
  int? dayIndex;
  String? startTime;
  String? endTime;
  String? courseId;
  CourseLevelCourse? course;
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
    course: json["course"] == null ? null : CourseLevelCourse.fromJson(json["course"]),
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

class WorksheetTemplate {
  String? title;
  String? description;
  int? classification;
  String? courseId;
  CourseLevelCourse? course;
  dynamic chapterId;
  dynamic chapter;
  dynamic topicId;
  dynamic topic;
  List<dynamic>? levelTemplateRelations;
  String? id;
  bool? isDeleted;

  WorksheetTemplate({
    this.title,
    this.description,
    this.classification,
    this.courseId,
    this.course,
    this.chapterId,
    this.chapter,
    this.topicId,
    this.topic,
    this.levelTemplateRelations,
    this.id,
    this.isDeleted,
  });

  factory WorksheetTemplate.fromJson(Map<String, dynamic> json) => WorksheetTemplate(
    title: json["title"],
    description: json["description"],
    classification: json["classification"],
    courseId: json["courseId"],
    course: json["course"] == null ? null : CourseLevelCourse.fromJson(json["course"]),
    chapterId: json["chapterId"],
    chapter: json["chapter"],
    topicId: json["topicId"],
    topic: json["topic"],
    levelTemplateRelations: json["levelTemplateRelations"] == null ? [] : List<dynamic>.from(json["levelTemplateRelations"]!.map((x) => x)),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "classification": classification,
    "courseId": courseId,
    "course": course?.toJson(),
    "chapterId": chapterId,
    "chapter": chapter,
    "topicId": topicId,
    "topic": topic,
    "levelTemplateRelations": levelTemplateRelations == null ? [] : List<dynamic>.from(levelTemplateRelations!.map((x) => x)),
    "id": id,
    "isDeleted": isDeleted,
  };
}
