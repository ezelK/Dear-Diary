import 'package:flutter/material.dart';

final ButtonStyle loginPageButton = TextButton.styleFrom(
  primary: const Color.fromRGBO(239, 235, 233, 1),
  backgroundColor: const Color.fromRGBO(62, 39, 35, 1),
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  side: const BorderSide(color: Color.fromARGB(255, 78, 52, 46)),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
);
