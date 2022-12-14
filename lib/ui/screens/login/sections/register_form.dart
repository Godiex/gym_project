import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/data/repositories/gym_owner_repository.dart';
import 'package:gym/domain/entities/gym_owner/create_gym_owner.dart';
import 'package:gym/ui/widgets/Inputs.dart';
import 'package:gym/ui/widgets/app_background.dart';
import 'package:gym/ui/widgets/button.dart';

import '../../../widgets/dialog.dart';
import '../../../widgets/spacer.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final Map<String, dynamic> formValues = {
    'identification': '',
    'names': '',
    'surnames': '',
    'email': '',
    'cellPhone': '',
    'userName': '',
    'password': '',
    'gymName': '',
    'address': '',
  };

  final GlobalWidgetDialog globalDialog = GlobalWidgetDialog();

  void createUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final GymOwnerRepository repository = new GymOwnerDefaultRepository();

    CreateGymOwner gymOwner = CreateGymOwner(
        identification: formValues['identification'],
        names: formValues['names'],
        surnames: formValues['surnames'],
        email: formValues['email'],
        cellPhone: formValues['cellPhone'],
        user: CreateUserGymOwner(
            userName: formValues['userName'],
            password: formValues['password'],
            typeUser: ''),
        gym: CreateGym(
            name: formValues['gymName'], address: formValues['address']));

    try {
      var test = await repository.create(gymOwner.toJson());
      globalDialog.seeDialogInfo(context, 'usuario creado con exito');
    } on DioError catch (_) {
      print(_);
      globalDialog.seeDialogError(context, _.response?.data['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text('Registro del gym y propiertario'),
        ),
      ),
      body: AppBackground(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                VSpacer(10),
                Text("Informacion del propietario"),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.card_travel,
                  label: "Numero de documento",
                  obscureText: false,
                  formValues: formValues,
                  FormProperty: 'identification',
                  validator: (value) {
                    if (value == null) return 'Este campo es requerido';
                    return value.length < 7 || value.length > 11
                        ? 'Entre 8 y 10 caracteres'
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
                  formValues: formValues,
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
                  formValues: formValues,
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
                  icon: Icons.supervised_user_circle,
                  label: "Email",
                  obscureText: false,
                  formValues: formValues,
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
                  formValues: formValues,
                  FormProperty: 'cellPhone',
                  validator: (value) {
                    if (value == null) return 'Este campo es requerido';
                    return value.length < 7 || value.length > 11
                        ? 'Entre 8 y 10 caracteres'
                        : !((RegExp(r'^[0-9]+$')).hasMatch(value ?? ''))
                            ? 'Sólo números'
                            : null;
                  },
                ),
                VSpacer(10),
                Text("Datos del usuario"),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.supervised_user_circle,
                  label: "Usuario",
                  obscureText: false,
                  formValues: formValues,
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
                  formValues: formValues,
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
                VSpacer(10),
                Text("Datos del Gym"),
                RadialInput(
                  color: Colors.white,
                  icon: Icons.sports_gymnastics,
                  label: "Nombre del gimnacio",
                  obscureText: false,
                  formValues: formValues,
                  FormProperty: 'gymName',
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
                  icon: Icons.supervised_user_circle,
                  label: "Direccion",
                  obscureText: false,
                  formValues: formValues,
                  FormProperty: 'address',
                  validator: (value) {
                    if (value == null) return 'Este campo es requerido';
                    return value.length < 4
                        ? 'Minimo 4 caracteres'
                        : !((RegExp(r'^[\w- ]+$')).hasMatch(value ?? ''))
                        ? 'Sólo letras y números'
                        : null;
                  },
                ),
                RadialButton(
                    color: Colors.black,
                    text: "Registrar",
                    press: createUser,
                    textColor: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
