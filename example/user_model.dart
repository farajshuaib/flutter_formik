class UserModel {
  String password;
  String email;

  UserModel({this.password = '', this.email = ''});

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(password: json['password'], email: json['email']);
  }
}