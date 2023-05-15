import 'package:flutter/material.dart';

const tileLeadingIconColor = Color.fromARGB(255, 70, 70, 70);
const inactiveTileLeadingIconColor = Color.fromARGB(255, 146, 144, 148);

class ProfileMenuItem extends StatelessWidget {
  ///
  final String title;

  ///
  final IconData icon;

  ///
  final VoidCallback? onPressed;

  ///
  final bool endIcon;

  const ProfileMenuItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.endIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        title,
      ),
      leading: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: tileLeadingIconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: tileLeadingIconColor),
      ),
      trailing: endIcon
          ? const SizedBox(
              width: 30,
              height: 30,
              child: Icon(
                Icons.chevron_right,
                size: 20.0,
                color: Colors.grey,
              ))
          : null,
    );
  }
}
