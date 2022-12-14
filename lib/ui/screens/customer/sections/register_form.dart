import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/configs/colors.dart';
import 'package:gym/data/repositories/gym_owner_repository.dart';
import 'package:gym/domain/entities/gym_owner/create_gym_owner.dart';
import 'package:gym/routes.dart';
import 'package:gym/ui/widgets/Inputs.dart';
import 'package:gym/ui/widgets/app_background.dart';
import 'package:gym/ui/widgets/button.dart';

import '../../../../data/repositories/customer_repository.dart';
import '../../../../states/theme/theme_cubit.dart';
import '../../../../states/user_info/user_info_bloc.dart';
import '../../../widgets/dialog.dart';
import '../../../widgets/spacer.dart';

class RegisterCustomer extends StatefulWidget {
  RegisterCustomer({super.key});

  @override
  State<RegisterCustomer> createState() => _RegisterCustomerState();
}

class _RegisterCustomerState extends State<RegisterCustomer> {
  final formKey = GlobalKey<FormState>();

  final Map<String, dynamic> userData = {
    'userName': '',
    'password': '',
  };

  final Map<String, dynamic> customerData = {
    'identification': '',
    'names': '',
    'surnames': '',
    'weight': 0,
    'tall': 0,
    'email': '',
    'cellPhone': '',
  };

  final GlobalWidgetDialog globalDialog = GlobalWidgetDialog();

  void createCustomer(gymId) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final CustomerRepository repository = new CustomerDefaultRepository();
    try {
      customerData["user"] = userData;
      customerData["gymId"] = gymId;
      customerData["tall"] = double.parse(customerData["tall"]);
      customerData["weight"] = double.parse(customerData["weight"]);
      await repository.create(customerData);
      globalDialog.seeDialogInfo(context, 'Cliente creado con exito');
    } on DioError catch (_) {
      print(_);
      globalDialog.seeDialogError(context, _.response?.data['message']);
    } on Exception catch (_) {
      print(_);
    }
  }

  @override
  Widget build(BuildContext context) {
    var userInfo =
        (BlocProvider.of<UserInfoBloc>(context, listen: true)).state.userInfo;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text('Registro de cliente'),
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
                  validator: (value) {
                    if (value == null) return 'Este campo es requerido';
                    return value.length < 7 || value.length > 11
                        ? 'Entre 7 y 11 caracteres'
                        : !((RegExp(r'^[\w-]+$')).hasMatch(value ?? ''))
                            ? 'Sólo letras y números'
                            : null;
                  },
                ),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.supervised_user_circle,
                  label: "Primer y Segundo Nombre",
                  obscureText: false,
                  formValues: customerData,
                  FormProperty: 'names',
                  validator: (value) {
                    if (value == null) return 'Este campo es requerido';
                    return value.length < 4
                        ? 'Minimo 4 caracteres'
                        : !((RegExp(r'^[a-zA-Z ]+$')).hasMatch(value ?? ''))
                            ? 'Sólo letras'
                            : null;
                  },
                ),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.lock,
                  label: "Primer y Segundo Apellido",
                  obscureText: false,
                  formValues: customerData,
                  FormProperty: 'surnames',
                  validator: (value) {
                    if (value == null) return 'Este campo es requerido';
                    return value.length < 4
                        ? 'Minimo 4 caracteres'
                        : !((RegExp(r'^[a-zA-Z ]+$')).hasMatch(value ?? ''))
                            ? 'Sólo letras'
                            : null;
                  },
                ),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.lock,
                  label: "Peso",
                  obscureText: false,
                  formValues: customerData,
                  FormProperty: 'weight',
                  validator: (value) {
                    if (value == null) return 'Este campo es requerido';
                    return !((RegExp(r'[0-9]')).hasMatch(value ?? ''))
                        ? 'Sólo números'
                        : null;
                  },
                ),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.lock,
                  label: "Altura",
                  obscureText: false,
                  formValues: customerData,
                  FormProperty: 'tall',
                  validator: (value) {
                    if (value == null) return 'Este campo es requerido';
                    return !((RegExp(r'[0-9]')).hasMatch(value ?? ''))
                        ? 'Sólo números'
                        : null;
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
                  validator: (value) {
                    RegExp regExp = new RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                    return value == null || value.isEmpty
                        ? 'Este campo es requerido'
                        : !(regExp.hasMatch(value ?? ''))
                            ? 'Debe digitar un correo válido'
                            : null;
                  },
                ),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.lock,
                  label: "Telefono - Celular",
                  obscureText: false,
                  formValues: customerData,
                  FormProperty: 'cellPhone',
                  validator: (value) {
                    if (value == null) return 'Este campo es requerido';
                    return value.length < 7 || value.length > 11
                        ? 'Entre 8 y 10 caracteres'
                        : !((RegExp(r'[0-9]')).hasMatch(value ?? ''))
                            ? 'Sólo números'
                            : null;
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
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Este campo es requerido';
                    return value.length < 4 ? 'Minimo 4 caracteres'
                        : !((RegExp(r'^[\w-]+$')).hasMatch(value ?? ''))
                        ? 'Sólo letras y números'
                        : null;
                  },
                ),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.lock,
                  label: "Contraseña",
                  obscureText: true,
                  formValues: userData,
                  FormProperty: 'password',
                  validator: (value) {
                    if (value == null) return 'Este campo es requerido';
                    return value.length < 6
                        ? 'Minimo 6 caracteres'
                        : !((RegExp(r'[0-9]')).hasMatch(value ?? ''))
                            ? 'Al menos un número'
                            : !((RegExp(r'[a-z]')).hasMatch(value ?? ''))
                                ? 'Al menos una minúscula'
                                : !((RegExp(r'[A-Z]')).hasMatch(value ?? ''))
                                    ? 'Al menos una mayúscula'
                                    : !((RegExp(r'[!@#$%^&*,.-/()=?¡¿{}+;:_°|<>]'))
                                            .hasMatch(value ?? ''))
                                        ? 'Al menos un caracter especial'
                                        : null;
                  },
                ),
                RadialButton(
                    color: AppColors.blue,
                    text: "Registrar",
                    press: () {
                      createCustomer(userInfo.gymId);
                    },
                    textColor: AppColors.blue),
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
            style:
                TextStyle(color: Colors.black, decorationColor: Colors.white),
            items: const [
              DropdownMenuItem(value: 'Admin', child: Text("Convesional")),
              DropdownMenuItem(value: 'Admin2', child: Text("Fichos")),
              DropdownMenuItem(value: 'Admin4', child: Text("Defensa personal"))
            ],
            onChanged: (value) {}),
      ),
    );
  }
}
