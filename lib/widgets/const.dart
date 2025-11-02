import 'package:flutter/material.dart';



class AppColors {
  static const primaryColor = Color(0xFF3D90D7);
  static const secondaryColor = Color(0xFF8BBCE7);
  static const white = Color(0xFFFFFFFF);
  static const fadeColor =  [primaryColor, secondaryColor, white];
}

class AppTextStyles {
  static const TextStyle bold20 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
}

class ColorType{
  static const Map<String, Color> typeColors = {
    'fire': Colors.red,
    'water': Colors.blue,
    'grass': Colors.green,
    'electric': Colors.yellow,
    'poison': Colors.deepPurple,
    'psychic': Colors.purple,
    'ice': Colors.cyan,
    'dragon': Colors.indigo,
    'normal': Colors.grey,
  };
}


