import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/configs/colors.dart';
import 'package:gym/data/repositories/customer_repository.dart';
import 'package:gym/routes.dart';
import 'package:gym/ui/screens/customer/sections/pokemon_info/customer_info.dart';
import 'package:gym/ui/screens/customer/sections/update_form.dart';

import '../../../../domain/entities/customer.dart';
import '../../../../domain/entities/user.dart';
import '../../../../states/theme/theme_cubit.dart';
import '../../../../states/user_info/user_info_bloc.dart';
import '../../../widgets/dialog.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  List<Customer> customers = [];

  _CustomerListState(){}

  Future<dynamic> getCustomers(context) async {
    var userInfoBloc = BlocProvider.of<UserInfoBloc>(context, listen: true);
    final UserInfo userInfo = userInfoBloc.state.userInfo;
    var customerRepository = new CustomerDefaultRepository();
    return await customerRepository.get(userInfo.gymId);
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
      body: FutureBuilder(
        future: getCustomers(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              List<Customer> _customers = snapshot.data;
              return ListCustomerCard(customers: _customers);
            default:
              return Text('Vuelva a la vista anterior e inténtelo de nuevo');
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppNavigator.push(Routes.customerCreate);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ListCustomerCard extends StatelessWidget {
  const ListCustomerCard({
    Key? key,
    required this.customers,
  }) : super(key: key);

  final List<Customer> customers;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemBuilder: (context, index) => CustomCard(customer: this.customers[index]),
          itemCount: this.customers.length,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        )
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final GlobalWidgetDialog globalDialog = GlobalWidgetDialog();
  var isDark = true;
  CustomCard({
    Key? key,
    required this.customer,
  }) : super(key: key);

  final Customer customer;

  void delete(customerId, context) async {
    try{
      globalDialog.getOptions(
          context, () async { await deleteCustomer(customerId, context);},
          "Alerta",
          Icons.delete,
          "Estas seguro que desea borrar al cliente",
          "Borrar",
          Icons.delete,
          isDark ? Colors.white : Colors.black);

    }
    on DioError catch (_) {
      print(_);
      globalDialog.seeDialogError(context, _.response?.data['message']);
    }
    on Exception catch (_) {
      print(_);
    }
  }

  Future deleteCustomer(customerId, context) async {
    var customerRepository = new CustomerDefaultRepository();
    await customerRepository.delete(customerId);
    globalDialog.seeDialogInfo(context, "cliente eliminado con exito");
  }

  @override
  Widget build(BuildContext context) {

    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    isDark = themeCubit.isDark;
    
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: isDark ? AppColors.grey : Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "${customer.names} ${customer.surnames}",
              style: TextStyle(
                decorationStyle: TextDecorationStyle.dashed,
                fontSize: 17.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.people, color: isDark ? Colors.white : Colors.black),
            subtitle: Text(
                "Plan : ${customer.plan?.name} con duracion de ${customer.plan?.duration} dias, informacion de contacto, correo ${customer.email}, telefono ${customer.cellPhone}",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove_red_eye, color: AppColors.blue),
                onPressed: () {final route = MaterialPageRoute(builder: (context) => CustomerInfo(customer:  customer));
                Navigator.push(context, route);},
              ),
              const SizedBox(width: 2),
              IconButton(
                icon: Icon(Icons.edit, color: AppColors.yellow),
                onPressed: () {
                    final route = MaterialPageRoute(builder: (context) => UpdateCustomer(customer:  customer));
                    Navigator.push(context, route);
                  },
              ),
              const SizedBox(width: 2),
              IconButton(
                icon: Icon(Icons.delete, color: AppColors.red),
                onPressed: () {delete(customer.id, context);},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
