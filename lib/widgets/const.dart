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
    'bug': Color(0xFF97A141),
    'ground': Color(0xFF915121),
    'fairy': Color(0xFFEF70EF)
  };
}

class FadeColor{
  static const Map<String, Color> typeColors = {
    'fire': Color(0xFFDF5B5B),
    'water': Color(0xFF69B0E8),
    'grass': Color(0xFF8DE891),
    'electric': Color(0xFFE8DC71),
    'poison': Color(0xFF9C73E4),
    'psychic': Color(0xFF9C63A5),
    'ice': Color(0xFF7FE0ED),
    'dragon': Color(0xFF5765B3),
    'normal': Color(0xFFFFFFFF),
    'bug': Color(0xFFCCD583),
    'ground': Color(0xFFBA835A),
    'fairy': Color(0xFFE497E4)
  };
}

