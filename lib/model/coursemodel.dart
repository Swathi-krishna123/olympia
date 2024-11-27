import 'dart:io';

class CourseModel {
  String? courseId;
  String? courseName;
  String? trainerName;
  String? contactNumber;
  bool? morningBatch;
  bool? eveningBatch;
  bool? kidsBatch;
  bool? ladiesBatch;
  String? courseFees;
  String? membership;
  String? moreDetails;
  String? morningTime;
  String? eveningTime;
  String? courseImage;

  CourseModel({
    this.courseId,
    this.courseName,
    this.courseFees,
    this.eveningBatch,
    this.kidsBatch,
    this.courseImage,
    this.ladiesBatch,
    this.membership,
    this.morningBatch,
    this.trainerName,
    this.contactNumber,
    this.moreDetails,
    this.morningTime,
    this.eveningTime,
  });

  factory CourseModel.fromjson(Map<String, dynamic> data) {
    return CourseModel(
      courseId:data['courseId'],
      courseName: data['courseName'],
      moreDetails: data['moreDetails'],
      trainerName: data['trainerName'],
      morningBatch: data['morningBatch'],
      eveningBatch: data['eveningBatch'],
      kidsBatch: data['kidsBatch'],
      ladiesBatch: data['ladiesBatch'],
      contactNumber: data['contactNumber'],
      courseFees: data['courseFees'],
      membership: data['membership'],
      morningTime: data['morningTime'],
      eveningTime: data['eveningTime'],
      courseImage: data['courseImage'],
    );
  }
// photo venam aa
  Map<String, dynamic> tomap() {
    return {
      "courseId":courseId,
      "courseName": courseName,
      "moreDetails": moreDetails,
      "trainerName": trainerName,
      "morningBatch": morningBatch,
      "eveningBatch": eveningBatch,
      "kidsBatch": kidsBatch,
      "ladiesBatch": ladiesBatch,
      "contactNumber": contactNumber,
      "courseFees": courseFees,
      "membership": membership,
      "morningTime": morningTime,
      "eveningTime": eveningTime,
      "courseImage": courseImage,
    };
  }
}
