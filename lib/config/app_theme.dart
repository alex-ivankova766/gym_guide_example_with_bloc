import 'package:flutter/material.dart';

class CustomTheme {
  ThemeData theme() {
    return ThemeData(

      
      primaryColor: const Color.fromARGB(221, 229, 236, 247),
      scaffoldBackgroundColor: const Color.fromARGB(221, 229, 236, 247),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(221, 190, 210, 243),
        shadowColor: Color.fromARGB(221, 41, 117, 238),
        elevation: 5,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.black87),
        titleMedium: TextStyle(color: Colors.black87),
        titleSmall: TextStyle(color: Colors.black87),
        bodyLarge: TextStyle(color: Colors.black87, fontSize: 18),
        bodyMedium: TextStyle(color: Colors.black87, fontSize: 14),
        bodySmall: TextStyle(color: Colors.black87),
      ),
      iconTheme: const IconThemeData(color: Colors.black87),
    );
  }
}
