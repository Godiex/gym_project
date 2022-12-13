import 'package:dio/dio.dart';
import 'package:gym/domain/entities/plan.dart';

import '../../core/network.dart';
import '../environment/env.dart';

abstract class AttendanceRepository {
  Future<bool> getAtendanceByCustomerId(String userId);
  Future postAtendanceByCustomerId(String route, String userId);
}

class AttendanceDefaultRepository extends AttendanceRepository {
  NetworkManager networkManager = new NetworkManager();

  @override
  Future<bool> getAtendanceByCustomerId(String userId) async {
    Response response = (await networkManager.request(
        RequestMethod.get, "${Env.apiBaseUrl}/Attendance/${userId}/today"));
    Map<String, dynamic> json = response.data;
    return json["attendanceToday"];
  }

  @override
  Future postAtendanceByCustomerId(String route, String userId) async {
    Response response = await networkManager.request(RequestMethod.post, route, data: {"userId": userId});
    return response.statusCode == 200 ? userId : null;
  }
}
