import 'package:dio/dio.dart';
import 'package:gym/domain/entities/plan.dart';

import '../../core/network.dart';
import '../../domain/entities/user.dart';
import '../environment/env.dart';

abstract class PlanRepository {
  Future getPlanCustomer(userId);
}

class PlanDefaultRepository extends PlanRepository {
  NetworkManager networkManager = new NetworkManager();

  @override
  Future<Plan> getPlanCustomer(userId) async {
    Response response = (await networkManager.request(
        RequestMethod.get,
        "${Env.apiBaseUrl}/Plan/${userId}/customer"
    ));
    return Plan.fromJson(response.data);
  }
}
