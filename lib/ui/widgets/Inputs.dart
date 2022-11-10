import 'package:flutter/material.dart';

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
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: Colors.grey[700],
            ),
            filled: true,
            hintText: label,
            fillColor: Colors.transparent,
            border: InputBorder.none,
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
