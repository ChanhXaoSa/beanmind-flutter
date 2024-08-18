// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? message;
  bool? success;
  int? code;
  UserData? data;
  dynamic errors;
  dynamic fieldErrors;

  UserModel({
    this.message,
    this.success,
    this.code,
    this.data,
    this.errors,
    this.fieldErrors,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    message: json["message"],
    success: json["success"],
    code: json["code"],
    data: json["data"] == null ? null : UserData.fromJson(json["data"]),
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

class UserData {
  String? id;
  String? userName;
  dynamic lastName;
  dynamic firstName;
  int? yearOfBirth;
  dynamic phoneNumber;
  String? email;
  bool? emailConfirmed;
  String? studentId;
  Student? student;
  String? teacherId;
  dynamic teacher;
  String? parentId;
  dynamic parent;
  List<dynamic>? sessions;
  List<dynamic>? teachables;
  List<UserDataEnrollment>? enrollments;
  List<String>? roles;

  UserData({
    this.id,
    this.userName,
    this.lastName,
    this.firstName,
    this.yearOfBirth,
    this.phoneNumber,
    this.email,
    this.emailConfirmed,
    this.studentId,
    this.student,
    this.teacherId,
    this.teacher,
    this.parentId,
    this.parent,
    this.sessions,
    this.teachables,
    this.enrollments,
    this.roles,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    userName: json["userName"],
    lastName: json["lastName"],
    firstName: json["firstName"],
    yearOfBirth: json["yearOfBirth"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    emailConfirmed: json["emailConfirmed"],
    studentId: json["studentId"],
    student: json["student"] == null ? null : Student.fromJson(json["student"]),
    teacherId: json["teacherId"],
    teacher: json["teacher"],
    parentId: json["parentId"],
    parent: json["parent"],
    sessions: json["sessions"] == null ? [] : List<dynamic>.from(json["sessions"]!.map((x) => x)),
    teachables: json["teachables"] == null ? [] : List<dynamic>.from(json["teachables"]!.map((x) => x)),
    enrollments: json["enrollments"] == null ? [] : List<UserDataEnrollment>.from(json["enrollments"]!.map((x) => UserDataEnrollment.fromJson(x))),
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "lastName": lastName,
    "firstName": firstName,
    "yearOfBirth": yearOfBirth,
    "phoneNumber": phoneNumber,
    "email": email,
    "emailConfirmed": emailConfirmed,
    "studentId": studentId,
    "student": student?.toJson(),
    "teacherId": teacherId,
    "teacher": teacher,
    "parentId": parentId,
    "parent": parent,
    "sessions": sessions == null ? [] : List<dynamic>.from(sessions!.map((x) => x)),
    "teachables": teachables == null ? [] : List<dynamic>.from(teachables!.map((x) => x)),
    "enrollments": enrollments == null ? [] : List<dynamic>.from(enrollments!.map((x) => x.toJson())),
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
  };
}

class ParticipantElement {
  String? enrollmentId;
  UserDataEnrollment? enrollment;
  String? sessionId;
  dynamic session;
  bool? isPresent;
  int? status;
  String? id;
  bool? isDeleted;

  ParticipantElement({
    this.enrollmentId,
    this.enrollment,
    this.sessionId,
    this.session,
    this.isPresent,
    this.status,
    this.id,
    this.isDeleted,
  });

  factory ParticipantElement.fromJson(Map<String, dynamic> json) => ParticipantElement(
    enrollmentId: json["enrollmentId"],
    enrollment: json["enrollment"] == null ? null : UserDataEnrollment.fromJson(json["enrollment"]),
    sessionId: json["sessionId"],
    session: json["session"],
    isPresent: json["isPresent"],
    status: json["status"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "enrollmentId": enrollmentId,
    "enrollment": enrollment?.toJson(),
    "sessionId": sessionId,
    "session": session,
    "isPresent": isPresent,
    "status": status,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class FluffyEnrollment {
  String? applicationUserId;
  PurpleApplicationUser? applicationUser;
  String? courseId;
  dynamic course;
  int? status;
  int? percentTopicCompletion;
  int? percentWorksheetCompletion;
  String? id;
  bool? isDeleted;

  FluffyEnrollment({
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

  factory FluffyEnrollment.fromJson(Map<String, dynamic> json) => FluffyEnrollment(
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"] == null ? null : PurpleApplicationUser.fromJson(json["applicationUser"]),
    courseId: json["courseId"],
    course: json["course"],
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
    "course": course,
    "status": status,
    "percentTopicCompletion": percentTopicCompletion,
    "percentWorksheetCompletion": percentWorksheetCompletion,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class ProcessionParticipant {
  String? enrollmentId;
  FluffyEnrollment? enrollment;
  String? sessionId;
  dynamic session;
  bool? isPresent;
  int? status;
  String? id;
  bool? isDeleted;

  ProcessionParticipant({
    this.enrollmentId,
    this.enrollment,
    this.sessionId,
    this.session,
    this.isPresent,
    this.status,
    this.id,
    this.isDeleted,
  });

  factory ProcessionParticipant.fromJson(Map<String, dynamic> json) => ProcessionParticipant(
    enrollmentId: json["enrollmentId"],
    enrollment: json["enrollment"] == null ? null : FluffyEnrollment.fromJson(json["enrollment"]),
    sessionId: json["sessionId"],
    session: json["session"],
    isPresent: json["isPresent"],
    status: json["status"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "enrollmentId": enrollmentId,
    "enrollment": enrollment?.toJson(),
    "sessionId": sessionId,
    "session": session,
    "isPresent": isPresent,
    "status": status,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Procession {
  String? participantId;
  ProcessionParticipant? participant;
  String? topicId;
  ProcessionTopic? topic;
  String? id;
  bool? isDeleted;

  Procession({
    this.participantId,
    this.participant,
    this.topicId,
    this.topic,
    this.id,
    this.isDeleted,
  });

  factory Procession.fromJson(Map<String, dynamic> json) => Procession(
    participantId: json["participantId"],
    participant: json["participant"] == null ? null : ProcessionParticipant.fromJson(json["participant"]),
    topicId: json["topicId"],
    topic: json["topic"] == null ? null : ProcessionTopic.fromJson(json["topic"]),
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

class TopicElement {
  String? title;
  String? description;
  dynamic order;
  String? chapterId;
  dynamic chapter;
  List<dynamic>? questions;
  List<dynamic>? worksheetTemplates;
  List<Procession>? processions;
  String? id;
  bool? isDeleted;

  TopicElement({
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

  factory TopicElement.fromJson(Map<String, dynamic> json) => TopicElement(
    title: json["title"],
    description: json["description"],
    order: json["order"],
    chapterId: json["chapterId"],
    chapter: json["chapter"],
    questions: json["questions"] == null ? [] : List<dynamic>.from(json["questions"]!.map((x) => x)),
    worksheetTemplates: json["worksheetTemplates"] == null ? [] : List<dynamic>.from(json["worksheetTemplates"]!.map((x) => x)),
    processions: json["processions"] == null ? [] : List<Procession>.from(json["processions"]!.map((x) => Procession.fromJson(x))),
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
    "processions": processions == null ? [] : List<dynamic>.from(processions!.map((x) => x.toJson())),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Chapter {
  String? title;
  String? description;
  dynamic order;
  String? courseId;
  dynamic course;
  List<TopicElement>? topics;
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
    course: json["course"],
    topics: json["topics"] == null ? [] : List<TopicElement>.from(json["topics"]!.map((x) => TopicElement.fromJson(x))),
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "order": order,
    "courseId": courseId,
    "course": course,
    "topics": topics == null ? [] : List<dynamic>.from(topics!.map((x) => x.toJson())),
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
  List<Chapter>? chapters;
  List<UserDataEnrollment>? enrollments;
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
    chapters: json["chapters"] == null ? [] : List<Chapter>.from(json["chapters"]!.map((x) => Chapter.fromJson(x))),
    enrollments: json["enrollments"] == null ? [] : List<UserDataEnrollment>.from(json["enrollments"]!.map((x) => UserDataEnrollment.fromJson(x))),
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
    "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x.toJson())),
    "enrollments": enrollments == null ? [] : List<dynamic>.from(enrollments!.map((x) => x.toJson())),
    "id": id,
    "isDeleted": isDeleted,
  };
}

class Student {
  String? applicationUserId;
  StudentApplicationUser? applicationUser;
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
    applicationUser: json["applicationUser"] == null ? null : StudentApplicationUser.fromJson(json["applicationUser"]),
    image: json["image"],
    school: json["school"],
    studentClass: json["class"],
    id: json["id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "applicationUserId": applicationUserId,
    "applicationUser": applicationUser?.toJson(),
    "image": image,
    "school": school,
    "class": studentClass,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class PurpleApplicationUser {
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
  List<UserDataEnrollment>? enrollments;

  PurpleApplicationUser({
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

  factory PurpleApplicationUser.fromJson(Map<String, dynamic> json) => PurpleApplicationUser(
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
    enrollments: json["enrollments"] == null ? [] : List<UserDataEnrollment>.from(json["enrollments"]!.map((x) => UserDataEnrollment.fromJson(x))),
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

class PurpleEnrollment {
  String? applicationUserId;
  PurpleApplicationUser? applicationUser;
  String? courseId;
  Course? course;
  List<ParticipantElement>? participants;
  List<dynamic>? worksheetAttempts;
  int? status;
  int? percentTopicCompletion;
  int? percentWorksheetCompletion;
  String? id;
  bool? isDeleted;

  PurpleEnrollment({
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

  factory PurpleEnrollment.fromJson(Map<String, dynamic> json) => PurpleEnrollment(
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"] == null ? null : PurpleApplicationUser.fromJson(json["applicationUser"]),
    courseId: json["courseId"],
    course: json["course"] == null ? null : Course.fromJson(json["course"]),
    participants: json["participants"] == null ? [] : List<ParticipantElement>.from(json["participants"]!.map((x) => ParticipantElement.fromJson(x))),
    worksheetAttempts: json["worksheetAttempts"] == null ? [] : List<dynamic>.from(json["worksheetAttempts"]!.map((x) => x)),
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
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
    "worksheetAttempts": worksheetAttempts == null ? [] : List<dynamic>.from(worksheetAttempts!.map((x) => x)),
    "status": status,
    "percentTopicCompletion": percentTopicCompletion,
    "percentWorksheetCompletion": percentWorksheetCompletion,
    "id": id,
    "isDeleted": isDeleted,
  };
}

class StudentApplicationUser {
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
  List<PurpleEnrollment>? enrollments;

  StudentApplicationUser({
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

  factory StudentApplicationUser.fromJson(Map<String, dynamic> json) => StudentApplicationUser(
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
    enrollments: json["enrollments"] == null ? [] : List<PurpleEnrollment>.from(json["enrollments"]!.map((x) => PurpleEnrollment.fromJson(x))),
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

class UserDataEnrollment {
  String? applicationUserId;
  StudentApplicationUser? applicationUser;
  String? courseId;
  Course? course;
  int? status;
  int? percentTopicCompletion;
  int? percentWorksheetCompletion;
  String? id;
  bool? isDeleted;
  List<dynamic>? participants;
  List<dynamic>? worksheetAttempts;

  UserDataEnrollment({
    this.applicationUserId,
    this.applicationUser,
    this.courseId,
    this.course,
    this.status,
    this.percentTopicCompletion,
    this.percentWorksheetCompletion,
    this.id,
    this.isDeleted,
    this.participants,
    this.worksheetAttempts,
  });

  factory UserDataEnrollment.fromJson(Map<String, dynamic> json) => UserDataEnrollment(
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"] == null ? null : StudentApplicationUser.fromJson(json["applicationUser"]),
    courseId: json["courseId"],
    course: json["course"] == null ? null : Course.fromJson(json["course"]),
    status: json["status"],
    percentTopicCompletion: json["percentTopicCompletion"],
    percentWorksheetCompletion: json["percentWorksheetCompletion"],
    id: json["id"],
    isDeleted: json["isDeleted"],
    participants: json["participants"] == null ? [] : List<dynamic>.from(json["participants"]!.map((x) => x)),
    worksheetAttempts: json["worksheetAttempts"] == null ? [] : List<dynamic>.from(json["worksheetAttempts"]!.map((x) => x)),
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
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x)),
    "worksheetAttempts": worksheetAttempts == null ? [] : List<dynamic>.from(worksheetAttempts!.map((x) => x)),
  };
}

class ProcessionTopic {
  String? title;
  String? description;
  dynamic order;
  String? chapterId;
  dynamic chapter;
  List<dynamic>? processions;
  String? id;
  bool? isDeleted;

  ProcessionTopic({
    this.title,
    this.description,
    this.order,
    this.chapterId,
    this.chapter,
    this.processions,
    this.id,
    this.isDeleted,
  });

  factory ProcessionTopic.fromJson(Map<String, dynamic> json) => ProcessionTopic(
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
