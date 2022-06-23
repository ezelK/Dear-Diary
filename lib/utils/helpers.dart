import 'package:flutter/material.dart';

class Helpers {
  static Future<DateTime?> showDateSelector(
    BuildContext context,
    DateTime firstDate,
    DateTime lastDate,
    DateTime initialDate,
  ) async {
    return await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: lastDate,
        initialDate: initialDate,
        cancelText: "Cancel",
        confirmText: "OK",
        helpText: "Select Date",
        builder: (ctx, widget) => Theme(
              data: ThemeData(
                primaryColor: const Color.fromARGB(255, 65, 11, 2),
                colorScheme:
                    const ColorScheme.light(primary: Color.fromARGB(255, 65, 11, 2)),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: widget!,
            ));
  }
}
