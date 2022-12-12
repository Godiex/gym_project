part of 'user_info_bloc.dart';

@immutable
abstract class UserInfoEvent {}

class LogInUserEvent extends UserInfoEvent {
  final UserInfo userInfo;
  LogInUserEvent(this.userInfo);
}
