import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../configs/colors.dart';
import '../../states/theme/theme_cubit.dart';

// ignore: must_be_immutable
class TextInput {
  Widget createTextField(
      TextEditingController controller, String label, IconData icon) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                icon: Icon(icon),
                filled: true,
                labelText: label,
                fillColor: Colors.transparent,
                hintText: label,
                suffix: GestureDetector(
                  child: const Icon(Icons.close),
                  onTap: () {
                    controller.clear();
                  },
                )),
          ),
        );
      },
    );
  }

  Widget createPasswordField(
      TextEditingController controller, String label, IconData icon) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: controller,
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(icon),
                filled: true,
                labelText: label,
                fillColor: Colors.transparent,
                hintText: label,
                suffix: GestureDetector(
                  child: const Icon(Icons.close),
                  onTap: () {
                    controller.clear();
                  },
                )),
          ),
        );
      },
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}

class RadialInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Color color;
  final IconData icon;
  final bool obscureText;
  const RadialInput({
    Key? key,
    required this.controller,
    required this.label,
    required this.color,
    required this.icon,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;
    return TextFieldContainer(
      child: TextFormField(

        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
            color: Colors.black.withOpacity(0.5),
        ),
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: Colors.black.withOpacity(0.5),
            ),
            filled: true,
            hintText: label,
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.5)
            ),
            fillColor: Colors.transparent,
            border: isDark ? InputBorder.none : null,
            focusedBorder: isDark ? null :  OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
            ),
            suffix: GestureDetector(
              child: const Icon(Icons.close),
              onTap: () {
                controller.clear();
              },
            )),
      ),
    );
  }
}
