import 'package:gym/domain/entities/item.dart';
import '../../core/network.dart';
import '../environment/env.dart';

abstract class GymOwnerRepository {
  Future create(gymOwner);
  Future<List<Item>> get(userId);
}

class GymOwnerDefaultRepository extends GymOwnerRepository {
  NetworkManager networkManager = new NetworkManager();

  @override
  Future create(gymOwner) async {
    return await networkManager.request(
        RequestMethod.post,
        "${Env.apiBaseUrl}/GymOwner",
        data: gymOwner
    );
  }

  @override
  Future<List<Item>> get(userId) {
    // TODO: implement get
    throw UnimplementedError();
  }
}
