import 'package:flutter/material.dart';

class Configs {
  static Color mainColor = const Color.fromRGBO(68, 202, 217, 1);
  static Color compColors1 = const Color.fromRGBO(217, 148, 68, 1);
  static Color compColors2 = const Color.fromRGBO(217, 73, 68, 1);

  static List<Color> colors = [
    const Color.fromARGB(255, 119, 13, 13),
    Colors.red.shade700,
    Colors.pink.shade600,
    Colors.deepOrange.shade400,
    Colors.orange,
    Colors.yellow.shade600,
    Colors.lime,
    Colors.lightGreen,
    Colors.green,
    Colors.teal,
    Colors.cyan.shade600,
  ];
  // TextStyle
  //TextFieldDecoration:
  static InputDecoration fieldDecoration = InputDecoration(
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0))),
    focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(color: compColors1)),
  );
  static InputDecoration skillfieldDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(color: compColors1)),
  );
}
