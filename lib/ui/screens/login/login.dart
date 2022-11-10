import 'package:flutter/material.dart';
import 'package:gym/ui/screens/login/sections/login_form.dart';
import 'package:gym/ui/widgets/app_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Stack(
        children: [
          LoginForm(),
        ],
      ),
    );
  }
}
