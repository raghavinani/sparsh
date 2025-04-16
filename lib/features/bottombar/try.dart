import 'package:flutter/material.dart';
import 'package:sprash_arch/features/ProfilePAge/View/profilePageorg.dart';
import 'package:sprash_arch/features/Screens/dsr_Visit.dart';

import 'package:sprash_arch/features/Screens/exportPage.dart';
import 'package:sprash_arch/features/bottombar/modal_bottom.dart';
import 'package:sprash_arch/features/home/view/home_page.dart';

import 'bottomNavAnimation.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  
  // List of pages to show
  final List<Widget> _pages = [
    ProfilePage2()  ,
    
    DSR(),
    Excelpage(),
    HomePage(),
      
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Show the selected page
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: NavigationView(
          onChangePage: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          curve: Curves.easeInBack,
          durationAnimation: const Duration(milliseconds: 400),
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
      ),
    );
  }
}

