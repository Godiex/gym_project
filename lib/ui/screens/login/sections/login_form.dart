import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/configs/images.dart';
import 'package:gym/routes.dart';
import 'package:gym/ui/screens/login/sections/register_form.dart';
import 'package:gym/ui/widgets/app_background.dart';

import '../../../../configs/colors.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../states/theme/theme_cubit.dart';
import '../../../widgets/Inputs.dart';
import '../../../widgets/button.dart';
import '../../../widgets/dialog.dart';


class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  final globalDialog = GlobalWidgetDialog();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final Map<String, dynamic> formValues = {
      'userName': '',
      'password': ''
    };

    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;
    Size size = MediaQuery.of(context).size;

    void registerUser(context) async{
      final route = MaterialPageRoute(builder: (context) => RegisterScreen());
      await Navigator.push(context, route);
    }

    void login() async{
      if(!formKey.currentState!.validate()){
        return;
      }
      FocusScope.of(context).requestFocus(FocusNode());
      final UserRepository repository = new UserDefaultRepository();
      try{
        Response test = await repository.logIn(formValues);
        AppNavigator.push(Routes.home, test.data);
      }
      on DioError catch (_) {
        print(_);
        globalDialog.seeDialogError(context, _.response?.data['message']);
      }
      catch (exception){
        print(exception);
      }
    }

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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          themeCubit.toggleTheme();
                        },
                        padding: EdgeInsets.only(
                          right: 28,
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
                  color: Colors.white,
                  icon: Icons.supervised_user_circle,
                  label: "Nombre de Usuario",
                  textInputType: TextInputType.emailAddress,
                  obscureText: false,
                  formValues: formValues,
                  FormProperty: 'userName',
                  validator: (value){
                    if (value == null) return 'Este campo es requerido';
                    return value.length < 8 ? 'Minimo 8 caracteres' : null;
                  },
                ),
                RadialInput(
                  color: !isDark ? AppColors.whiteGrey : Colors.black.withOpacity(0.5),
                  icon: Icons.lock,
                  label: "Contraseña",
                  obscureText: true,
                  formValues: formValues,
                  FormProperty: 'password',
                  validator: (value){
                    if (value == null) return 'Este campo es requerido';
                    return value.length < 6 ? 'Minimo 6 caracteres' : null;
                  },
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