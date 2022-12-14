import 'package:dio/dio.dart';
import 'package:gym/domain/entities/attendance.dart';
import 'package:http/http.dart' as http;

import '../../core/network.dart';
import '../environment/env.dart';

abstract class AttendanceRepository {
  Future<bool> getAttendanceByCustomerId(String userId);
  Future postAttendanceByCustomerId(String route, String userId);
  Future<List<Attendance>> get(gymId);
}

class AttendanceDefaultRepository extends AttendanceRepository {
  NetworkManager networkManager = new NetworkManager();

  @override
  Future<bool> getAttendanceByCustomerId(String userId) async {
    Response response = (await networkManager.request(
        RequestMethod.get, "${Env.apiBaseUrl}/Attendance/${userId}/today"));
    Map<String, dynamic> json = response.data;
    return json["attendanceToday"];
  }

  @override
  Future<List<Attendance>> get(gymId) async {
    var url = "${Env.apiBaseUrl}/Attendance/${gymId}/gym";
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    return AttendanceFromJson(response.body);
  }

  @override
  Future postAttendanceByCustomerId(String route, String userId) async {
    Response response = await networkManager.request(RequestMethod.post, route, data: {"userId": userId});
    return response.statusCode == 200 ? userId : null;
  }
}
