import '../../core/network.dart';
import '../environment/env.dart';

abstract class UserRepository {
  Future logIn(user);
}

class UserDefaultRepository extends UserRepository {
  NetworkManager networkManager = new NetworkManager();

  @override
  Future logIn(user) async {
    return await networkManager.request(
        RequestMethod.post,
        "${Env.apiBaseUrl}/User",
        data: user
    );
  }
}
