import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF8C5651),
      title: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Realm',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF52222),
                fontFamily: 'VT323',
              ),
            ),
            TextSpan(
              text: 'Builder',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF23A255),
                fontFamily: 'VT323',
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
      toolbarHeight: 80,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}