import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
  AppLargeText(
      {Key? key, this.size = 30, required this.text, this.color = Colors.black})
      : super(key: key);

  int size;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: size.toDouble(),
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
