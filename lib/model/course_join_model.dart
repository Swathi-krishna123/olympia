class CourseJoinModel {
  String? userName;
  String? courseName;
  String? phoneNumber;
  String? email;
  bool? morningBatch;
  bool? eveningBatch;
  String? userId;
  CourseJoinModel(
      {this.userName,
      this.courseName,
      this.phoneNumber,
      this.userId,
      this.email,
      this.morningBatch,
      this.eveningBatch});

  factory CourseJoinModel.fromjson(Map<String, dynamic> data) {
    return CourseJoinModel(
      userName: data['userName'],
      courseName: data['courseName'],
      phoneNumber: data['phoneNumber'],
      email: data['email'],
      morningBatch: data['morningBatch'],
      eveningBatch: data['eveningBatch'],
      userId: data['userId'],
    );
  }

  Map<String, dynamic> tomap() {
    return {
      "userName": userName,
      "courseName": courseName,
      "phoneNumber": phoneNumber,
      "email": email,
      "morningBatch": morningBatch,
      "eveningBatch": eveningBatch,
      "userId": userId,
    };
  }
}
