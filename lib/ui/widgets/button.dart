import 'package:flutter/material.dart';

class RadialButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final Color textColor;
  const RadialButton({
    Key? key,
    required this.text,
    required this.press,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          ),
          onPressed: () => press(),
          child: Text(
            text,
          )
        ),
      ),
    );
  }
}

class FloatButton extends StatelessWidget {
  final Function press;
  final Color color;
  const FloatButton({required Key key, required this.press, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => press(),
      backgroundColor: color,
      child: const Icon(Icons.add),
    );
  }
}
