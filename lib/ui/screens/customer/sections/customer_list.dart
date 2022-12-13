import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/data/repositories/customer_repository.dart';

import '../../../../domain/entities/customer.dart';
import '../../../../domain/entities/user.dart';
import '../../../../states/user_info/user_info_bloc.dart';
import '../../../widgets/button.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  List<Customer> customers = [];

  _CustomerListState(){}

  Future<List<Customer>> getCustomers() async {
    var userInfoBloc = BlocProvider.of<UserInfoBloc>(context, listen: true);
    final UserInfo userInfo = userInfoBloc.state.userInfo;
    var customerRepository = new CustomerDefaultRepository();
    this.customers = await customerRepository.get(userInfo.gymId);
    return this.customers;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text('Gestion de clientes'),
        ),
      ),
      body: BlocBuilder<UserInfoBloc, UserInfoState>(
        builder: (context, state) {
          final UserInfo userInfo = state.userInfo;
          var customerRepository = new CustomerDefaultRepository();
          return Container(
            child: FutureBuilder<List<Customer>>(
              future: customerRepository.get(userInfo.gymId),
              builder: (context, snapshot) {
                return Text("${snapshot.data}");
              },
            ),
          );
        },
      )
    );
  }
}
