import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/configs/images.dart';
import 'package:gym/ui/screens/login/sections/register_form.dart';
import 'package:gym/ui/widgets/app_background.dart';

import '../../../../configs/colors.dart';
import '../../../../domain/entities/user.dart';
import '../../../../routes.dart';
import '../../../../states/theme/theme_cubit.dart';
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
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    List<User> users = [];

    void registerUser(context) async{
      final route = MaterialPageRoute(builder: (context) => RegisterScreen(user:  User(),));
      final user = await Navigator.push(context, route) as User;
      users.add(user);
      globalDialog.seeDialogInfo(context, "usuario registrado con exito");
    }

    void login(){
      AppNavigator.push(Routes.items);
    }

    var isDark = themeCubit.isDark;
    Size size = MediaQuery.of(context).size;

    Widget _buildTitle() {
      return Container(
          child: Text(
            'Inicio de sesion',
            style: TextStyle(
              fontSize: 30,
              height: 1.6,
              fontWeight: FontWeight.w900,
            ),
          ),
      );
    }

    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        themeCubit.toggleTheme();
                      },
                      padding: EdgeInsets.only(
                        left: 28,
                      ),
                      icon: Icon(
                        isDark ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined,
                        color: isDark ? Colors.yellow : Colors.black,
                        size: 25,
                      )),
                ),
              ),
              _buildTitle(),
              Image(
                image: AppImages.gym_logo,
                height: size.height * 0.4,
                color: Colors.black.withOpacity(0.5),
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
                color: !isDark ? AppColors.whiteGrey : Colors.black.withOpacity(0.5),
                icon: Icons.lock,
                label: "Contraseña",
                obscureText: true,
              ),
              RadialButton(
                  color: !isDark ? AppColors.whiteGrey : Colors.black.withOpacity(0.5),
                  text: "Entrar",
                  press: login,
                  textColor: !isDark ? Colors.black.withOpacity(0.5) : AppColors.whiteGrey
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
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
         Text(
          "¿Aun no tienes cuenta? ",
          style: TextStyle(color: !isDark ? Colors.black.withOpacity(0.5) : AppColors.whiteGrey),
        ),
        GestureDetector(
          onTap: () => {
            registerUser(context, )
          },
          child: Text(
            "Registrate Aca",
            style: TextStyle(
              color: !isDark ? Colors.black.withOpacity(0.5) : AppColors.whiteGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}