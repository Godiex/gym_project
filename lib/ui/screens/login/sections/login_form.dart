import 'package:flutter/material.dart';
import 'package:gym/ui/screens/login/sections/register_form.dart';
import 'package:gym/ui/widgets/app_background.dart';

import '../../../../domain/entities/user.dart';
import '../../../widgets/Inputs.dart';
import '../../../widgets/button.dart';
import '../../../widgets/dialog.dart';


class LoginForm extends StatelessWidget {
  final GlobalWidgetDialog globalDialog = GlobalWidgetDialog();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {

    List<User> users = [];

    void registerUser(context) async{
      final route = MaterialPageRoute(builder: (context) => RegisterScreen(user:  User(),));
      final user = await Navigator.push(context, route) as User;
      users.add(user);
      globalDialog.seeDialogInfo(context, "usuario registrado con exito");
    }

    void login(){
      if(passwordController.text.isNotEmpty && userNameController.text.isNotEmpty){
        int exist = users.indexWhere((user) => user.password == passwordController.text && user.userName == userNameController.text);
        if(exist == -1){
          globalDialog.seeDialogError(context, 'No existe el usuario');
        }
        else{
          Navigator.pushNamed(context, 'listview2');
        }
      }
    }

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: const AssetImage('assets/images/logo_login.png'),
                height: size.height * 0.31,
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
                  text: "Entrar",
                  press: login,
                  textColor: Colors.white
              ),
              Padding(
              padding: const EdgeInsets.all(5.0),
                child: LoginDetail(registerUser: registerUser),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginDetail extends StatelessWidget {

  final Function registerUser;

  const LoginDetail({
    Key? key,
    required this.registerUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "¿Aun no tienes cuenta? ",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: () => {
            registerUser(context, )
          },
          child: const Text(
            "Registrate Aca",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}