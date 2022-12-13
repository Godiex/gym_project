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
  String gymId;

  UserInfo({
    this.id = "",
    this.typeUser = "",
    this.gymId = "",
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    typeUser: json["typeUser"],
    id: json["userId"],
    gymId: json["gymId"],
  );
}
