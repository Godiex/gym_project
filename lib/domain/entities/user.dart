class LogInUser {
  String? userName;
  String? password;

  LogInUser({
    this.userName,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password
    };
  }
}

class UserInfo {
  String id;
  String typeUser;

  UserInfo({
    this.id = "",
    this.typeUser = "",
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    typeUser: json["typeUser"],
    id: json["userId"],
  );
}
