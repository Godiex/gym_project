part of 'user_info_bloc.dart';

@immutable
abstract class UserInfoState {
  final UserInfo userInfo;
  UserInfoState(this.userInfo);
}

class UserInfoInitial extends UserInfoState {
  UserInfoInitial() : super(new UserInfo(id: "", typeUser: ""));
}

class UserInfoLoggedState extends UserInfoState {
  UserInfoLoggedState(UserInfo userInfo) : super(userInfo){
    print("hola estoy emitiendo este evetno");
  }
}
