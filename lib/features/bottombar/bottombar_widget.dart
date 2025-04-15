import 'package:flutter/material.dart';
import 'package:sprash_arch/features/bottombar/bottomNav.dart';
import 'package:sprash_arch/features/bottombar/modal_bottom.dart';

Widget customBottomNavigationBar({
  required ValueChanged<int> onChangePage,
  Curve curve = Curves.easeInBack,
  Duration durationAnimation = const Duration(milliseconds: 400),
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: NavigationView(
      onChangePage: onChangePage,
      curve: curve,
      durationAnimation: durationAnimation,
      items: [
        ItemNavigationView(
          childAfter: const Icon(Icons.person_rounded, color: Colors.blue, size: 30),
          childBefore: Icon(Icons.person_outlined, color: Colors.black, size: 30),
        ),
        ItemNavigationView(
          childAfter: const Icon(Icons.mail_rounded, color: Colors.blue, size: 30),
          childBefore: Icon(Icons.mail_outlined, color: Colors.black, size: 30),
        ),
        ItemNavigationView(
          childAfter: const Icon(Icons.task_rounded, color: Colors.blue, size: 30),
          childBefore: Icon(Icons.task_outlined, color: Colors.black, size: 30),
        ),
        ItemNavigationView(
          childAfter: const Icon(Icons.home_rounded, color: Colors.blue, size: 30),
          childBefore: Icon(Icons.home_outlined, color: Colors.black, size: 30),
        ),
      ],
    ),
  );
}