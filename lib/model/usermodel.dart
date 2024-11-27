class UserModel {
  String? name;
  String? id;
  String? email;
  String? phone;
  String? password;
  bool isPresent;
  String? course;
  String? role;

  UserModel(
      {this.name,
      this.id,
      this.isPresent = false,
      this.email,
      this.phone,
      this.password,
      this.course,
      this.role});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
        id: data['id'],
        name: data['name'],
        course: data['course'],
        email: data['email'],
        isPresent: data['isPresent'],
        password: data['password'],
        phone: data['phone'],
        role: data['role']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'course': course,
      'email': email,
      'isPresent': isPresent,
      'password': password,
      'phone': phone,
      'role': role
    };
  }
}
