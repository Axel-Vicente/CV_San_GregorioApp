import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.interTextTheme(),
  colorScheme: ColorScheme.dark(
    primary: Colors.grey[800]!, // color para widgets
    secondary: Colors.red, // rojo como color de acento
    background: Colors.black, // fondo de pantallas
    surface: const Color.fromARGB(255, 63, 63, 63), // tarjetas, inputs, etc.
    onPrimary: Colors.white, // texto sobre primary
    onSecondary: Colors.white, // texto sobre secondary
    onSurface: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.black,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[850],
    labelStyle: const TextStyle(color: Colors.white70),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white30),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white30),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
);
