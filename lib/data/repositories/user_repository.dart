import 'package:dio/dio.dart';

import '../../core/network.dart';
import '../../domain/entities/user.dart';
import '../environment/env.dart';

abstract class UserRepository {
  Future logIn(user);
}

class UserDefaultRepository extends UserRepository {
  NetworkManager networkManager = new NetworkManager();

  @override
  Future<UserInfo> logIn(user) async {
    Response response = (await networkManager.request(
        RequestMethod.post,
        "${Env.apiBaseUrl}/User",
        data: user
    ));
    return UserInfo.fromJson(response.data);
  }
}
