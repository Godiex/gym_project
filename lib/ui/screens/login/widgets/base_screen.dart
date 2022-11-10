import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  const BaseScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image(
              image: const AssetImage('assets/images/signup-top.png'),
              width: size.width * 0.3,
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Image(
                image: const AssetImage('assets/images/login-bottom.png'),
                width: size.width * 0.38,
              )),
          child,
        ],
      ),
    );
  }
}
