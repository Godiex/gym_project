import 'package:flutter/material.dart';

class GlobalWidgetDialog {
  void seeDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: getTitle(
                  '¡Advertencia!', Icons.error, Colors.orange[400]!),
              content: Text(message, style: const TextStyle(color: Colors.blueGrey)),
              actions: [
                createButton(() => Navigator.pop(context), '  Volver',
                    Icons.keyboard_return, Colors.blueGrey),
              ],
            ));
  }

  void seeDialogInfo(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: getTitle(
                  '¡Enhorabuena!', Icons.info, Colors.blueAccent[400]!),
              content: Text(message, style: const TextStyle(color: Colors.blueGrey)),
              actions: [
                createButton(() => Navigator.pop(context), '  Volver',
                    Icons.keyboard_return, Colors.blueGrey),
              ],
            ));
  }

  void seeDialogError(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: getTitle('¡Oh no!', Icons.dangerous, Colors.red[400]!),
              content: Text(message, style: const TextStyle(color: Colors.blueGrey)),
              actions: [
                createButton(() => Navigator.pop(context), '  Volver',
                    Icons.keyboard_return, Colors.blueGrey),
              ],
            ));
  }

  Row getTitle(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color),
        Text(title, style: TextStyle(color: color)),
      ],
    );
  }

  TextButton createButton(
      Function function, String text, IconData icon, Color color) {
    return TextButton(
        onPressed: () => function(),
        child: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, color: color),
            Text(text, style: TextStyle(color: color)),
          ]),
        ));
  }

  void getOptions(
      BuildContext context,
      Function function,
      String title,
      IconData iconTitle,
      String message,
      String button,
      IconData icon,
      Color color) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: getTitle(title, iconTitle, color),
              content: Text(message, style: const TextStyle(color: Colors.blueGrey)),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    createButton(function, ' $button', icon, color),
                    createButton(() => Navigator.pop(context), '  Cancelar',
                        Icons.cancel, Colors.blueGrey),
                  ],
                )
              ],
            ));
  }
}
