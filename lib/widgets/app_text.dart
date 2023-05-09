import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  AppText(
      {Key? key,
      this.size = 16,
      required this.text,
      this.color = Colors.black54})
      : super(key: key);

  int size;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        fontSize: size.toDouble(),
        color: color,
      ),
    );
  }
}
