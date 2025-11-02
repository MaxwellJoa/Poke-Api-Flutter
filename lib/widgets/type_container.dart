import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/widgets/const.dart';

class TypeContainer extends StatelessWidget {
  const TypeContainer({
    super.key,
    required this.tipoName,
    required this.tipoColor
  });

  final String tipoName;
  final Color tipoColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            color: Colors.grey.shade200,
            spreadRadius: 5,
            blurRadius: 7,
          ),
        ],
        color: tipoColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(child: Text(tipoName, style: AppTextStyles.bold20,)),
    );
  }
}