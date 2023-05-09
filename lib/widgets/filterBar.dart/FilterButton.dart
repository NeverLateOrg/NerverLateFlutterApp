import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton(
      {Key? key, this.isSelected, required this.text, required this.onPressed})
      : super(key: key);

  final bool? isSelected;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textColor = isSelected == true
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.tertiary;
    final backgroundColor = isSelected == true
        ? Theme.of(context).colorScheme.tertiary
        : Theme.of(context).colorScheme.primary;
    return TextButton(
      onPressed: () {
        onPressed();
      },
      style: TextButton.styleFrom(
        side: BorderSide(
          color: Theme.of(context).colorScheme.tertiary,
          width: 2,
        ),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
