import 'package:flutter/material.dart';
import 'package:sprash_arch/features/bottombar/bottomNavAnimation.dart';
import 'package:sprash_arch/features/bottombar/modal_bottom.dart';

// Import your actual pages
import 'package:sprash_arch/features/ProfilePAge/View/profilePageorg.dart';
import 'package:sprash_arch/features/Screens/dsr_Visit.dart';
import 'package:sprash_arch/features/Screens/exportPage.dart';
import 'package:sprash_arch/features/home/view/home_page.dart';

Widget customBottomNavigationBar({
  required BuildContext context,
  required int currentIndex,
  Curve curve = Curves.easeInBack,
  Duration durationAnimation = const Duration(milliseconds: 200),
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: NavigationView(
      currentPage: currentIndex,
      onChangePage: (index) async {
        if (index == currentIndex) return;
        await Future.delayed(durationAnimation);

        Widget nextPage;

        switch (index) {
          case 0:
            nextPage = ProfilePage2();
            break;
          case 1:
            nextPage = DSR();
            break;
          case 2:
            nextPage = Excelpage();
            break;
          case 3:
          default:
            nextPage = HomePage();
        }

        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: durationAnimation,
            pageBuilder: (_, __, ___) => nextPage,
            transitionsBuilder: (_, animation, __, child) {
              final curved = CurvedAnimation(parent: animation, curve: curve);
              return FadeTransition(opacity: curved, child: child);
            },
          ),
        );
      },
      curve: curve,
      durationAnimation: durationAnimation,
      items: [
        ItemNavigationView(
          childAfter:
              const Icon(Icons.person_rounded, color: Colors.blue, size: 30),
          childBefore:
              Icon(Icons.person_outlined, color: Colors.black, size: 30),
        ),
        ItemNavigationView(
          childAfter:
              const Icon(Icons.mail_rounded, color: Colors.blue, size: 30),
          childBefore: Icon(Icons.mail_outlined, color: Colors.black, size: 30),
        ),
        ItemNavigationView(
          childAfter:
              const Icon(Icons.task_rounded, color: Colors.blue, size: 30),
          childBefore: Icon(Icons.task_outlined, color: Colors.black, size: 30),
        ),
        ItemNavigationView(
          childAfter:
              const Icon(Icons.home_rounded, color: Colors.blue, size: 30),
          childBefore: Icon(Icons.home_outlined, color: Colors.black, size: 30),
        ),
      ],
    ),
  );
}
