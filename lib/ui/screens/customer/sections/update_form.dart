import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/configs/colors.dart';
import 'package:gym/ui/widgets/Inputs.dart';
import 'package:gym/ui/widgets/app_background.dart';
import 'package:gym/ui/widgets/button.dart';

import '../../../../data/repositories/customer_repository.dart';
import '../../../../domain/entities/customer.dart';
import '../../../widgets/dialog.dart';
import '../../../widgets/spacer.dart';

class UpdateCustomer extends StatefulWidget {
  final Customer customer;

  UpdateCustomer({
    super.key,
    required this.customer
  });

  @override
  State<UpdateCustomer> createState() => _UpdateCustomerState();
}

class _UpdateCustomerState extends State<UpdateCustomer> {
  final formKey = GlobalKey<FormState>();
  final Map<String, dynamic> userData = {
    'userName': '',
    'password': '',
  };

  final Map<String, dynamic> customerData = {
    'identification': "",
    'names': '',
    'surnames': '',
    'weight': 0,
    'tall': 0,
    'email': '',
    'cellPhone': '',
  };

  final GlobalWidgetDialog globalDialog = GlobalWidgetDialog();

  void mapCustomer(Customer customer) async {
    customerData['identification'] = customer.identification;
    customerData['names'] = customer.names;
    customerData['surnames'] = customer.surnames;
    customerData['weight'] = customer.weight;
    customerData['tall'] = customer.tall;
    customerData['email'] = customer.email;
    customerData['cellPhone'] = customer.cellPhone;
    userData['userName'] = customer.email;
    userData['password'] = customer.cellPhone;
  }

  void updateCustomer() async {
    if(!formKey.currentState!.validate()){
      return;
    }
    final CustomerRepository repository = new CustomerDefaultRepository();
    try{
      customerData["user"] = userData;
      customerData["id"] = widget.customer.id;
      customerData["tall"] = double.parse(customerData["tall"]);
      customerData["weight"] = double.parse(customerData["weight"]);
      await repository.update(customerData);
      globalDialog.seeDialogInfo(context, 'Cliente creado con exito');
    }
    on DioError catch (_) {
      print(_);
      globalDialog.seeDialogError(context, _.response?.data['message']);
    }
    on Exception catch (_) {
      print(_);
    }
  }

  @override
  void initState() {
    var customer = widget.customer;
    mapCustomer(customer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text('Actualizacion de cliente'),
        ),
      ),
      body: AppBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                VSpacer(10),
                Text("Informacion del cliente"),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.supervised_user_circle,
                  label: "Numero de documento",
                  obscureText: false,
                  formValues: customerData,
                  FormProperty: 'identification',
                  initialValue: widget.customer.identification,
                  enabled: false,
                ),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.supervised_user_circle,
                  label: "Primer y Segundo Nombre",
                  obscureText: false,
                  formValues: customerData,
                  FormProperty: 'names',
                  initialValue: widget.customer.names,
                  validator: (value){
                    if (value == null) return 'Este campo es requerido';
                    return value.length < 4 ? 'Minimo 4 caracteres' : null;
                  },
                ),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.lock,
                  label: "Primer y Segundo Apellido",
                  obscureText: false,
                  formValues: customerData,
                  FormProperty: 'surnames',
                  initialValue: widget.customer.surnames,
                  validator: (value){
                    if (value == null) return 'Este campo es requerido';
                    return value.length < 4 ? 'Minimo 4 caracteres' : null;
                  },
                ),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.lock,
                  label: "Peso",
                  obscureText: false,
                  formValues: customerData,
                  FormProperty: 'weight',
                  initialValue: widget.customer.weight,
                  validator: (value){
                    if (value == null) return 'Este campo es requerido';
                    return null;
                  },
                ),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.lock,
                  label: "Altura",
                  obscureText: false,
                  formValues: customerData,
                  FormProperty: 'tall',
                  initialValue: widget.customer.tall,
                  validator: (value){
                    if (value == null) return 'Este campo es requerido';
                    return null;
                  },
                ),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.supervised_user_circle,
                  label: "Email",
                  obscureText: false,
                  formValues: customerData,
                  FormProperty: 'email',
                  textInputType: TextInputType.emailAddress,
                  initialValue: widget.customer.email,
                  validator: (value){
                    if (value == null || value.isEmpty) return 'Este campo es requerido';
                    return null;
                  },
                ),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.lock,
                  label: "Telefono - Celular",
                  obscureText: false,
                  formValues: customerData,
                  FormProperty: 'cellPhone',
                  initialValue: widget.customer.cellPhone,
                  validator: (value){
                    if (value == null) return 'Este campo es requerido';
                    return value.length < 7 || value.length > 11 ? 'Entre 8 y 10 caracteres' : null;
                  },
                ),
                DropDownCustom(),
                VSpacer(10),
                Text("Datos del usuario"),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.supervised_user_circle,
                  label: "Usuario",
                  obscureText: false,
                  formValues: userData,
                  FormProperty: 'userName',
                  initialValue: widget.customer.user?.userName,
                  validator: (value ){
                    if (value == null || value.isEmpty) return 'Este campo es requerido';
                    return null;
                  },
                ),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.lock,
                  label: "Contraseña",
                  obscureText: true,
                  formValues: userData,
                  FormProperty: 'password',
                  initialValue: widget.customer.user?.password,
                  validator: (value){
                    if (value == null) return 'Este campo es requerido';
                    return value.length < 6 ? 'Minimo 6 caracteres' : null;
                  },
                ),
                RadialButton(
                    color: AppColors.blue,
                    text: "Actualizar",
                    press: () { updateCustomer();},
                    textColor: AppColors.blue
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropDownCustom extends StatelessWidget {
  const DropDownCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField<String>(
            value: "Admin",
            dropdownColor: Colors.white,
            focusColor: Colors.amber,
            style: TextStyle(
              color:  Colors.black,
              decorationColor: Colors.white
            ),
            items: const [
              DropdownMenuItem(value: 'Admin', child: Text("Convesional")),
              DropdownMenuItem(value: 'Admin2' ,child: Text("Fichos")),
              DropdownMenuItem(value: 'Admin4',child: Text("Defensa personal"))
            ],
            onChanged: (value) {}
        ),
      ),
    );
  }
}