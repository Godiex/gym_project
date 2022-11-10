import 'package:flutter/material.dart';
import 'package:gym/ui/widgets/Inputs.dart';
import 'package:gym/ui/widgets/app_background.dart';
import 'package:gym/ui/widgets/button.dart';

import '../../../../domain/entities/user.dart';
import '../../../widgets/dialog.dart';

class RegisterScreen extends StatefulWidget {
  final User user;

  const RegisterScreen({
    super.key,
    required this.user
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final GlobalWidgetDialog globalDialog = GlobalWidgetDialog();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController surnameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();

  void createUser(){
    if (nameController.text.isNotEmpty &&
        surnameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        userNameController.text.isNotEmpty) {
      widget.user.name = nameController.text;
      widget.user.surname = surnameController.text;
      widget.user.userName = userNameController.text;
      widget.user.password = passwordController.text;
      Navigator.pop(context, widget.user);
    } else {
      globalDialog.seeDialogInfo(context, "Hay Uno O Mas Campos Vacios");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text('Registro de persona'),
        ),
      ),
      body: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RadialInput(
                controller: nameController,
                color: Colors.white,
                icon: Icons.supervised_user_circle,
                label: "Primer y Segundo Nombre",
                obscureText: false,
              ),
              RadialInput(
                controller: surnameController,
                color: Colors.white,
                icon: Icons.lock,
                label: "Primer y Segundo Apellido",
                obscureText: false,
              ),
              RadialInput(
                controller: userNameController,
                color: Colors.white,
                icon: Icons.supervised_user_circle,
                label: "Nombre de Usuario",
                obscureText: false,
              ),
              RadialInput(
                controller: passwordController,
                color: Colors.white,
                icon: Icons.lock,
                label: "Contraseña",
                obscureText: true,
              ),
              RadialButton(
                  color: Colors.black,
                  text: "Registrar",
                  press: createUser,
                  textColor: Colors.white
              ),
            ],
          ),
        ),
      ),
    );
  }
}