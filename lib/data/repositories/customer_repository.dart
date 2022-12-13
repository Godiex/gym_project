import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:gym/domain/entities/customer.dart';

import '../../core/network.dart';
import '../environment/env.dart';

abstract class CustomerRepository {
  Future get(gymId);
}

class CustomerDefaultRepository extends CustomerRepository {
  NetworkManager networkManager = new NetworkManager();

  @override
  Future<List<Customer>> get(gymId) async {
    var url = "${Env.apiBaseUrl}/Customer/${gymId}/gym";
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    return CustomerFromJson(response.body);
  }
}
