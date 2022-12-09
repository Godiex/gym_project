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
