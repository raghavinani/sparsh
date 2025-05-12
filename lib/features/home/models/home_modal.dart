import 'package:flutter/material.dart';

class GridItem {
  final IconData icon;
  final String title;
  final Color color;

  GridItem({required this.icon, required this.title, required this.color});
}

int selectedTabIndex = 0;
final List<String> tabTitles = [
  'Quick Menu',
  'Dashboard',
  'Document',
  'Trending',
];

final appData = [
  {'name': 'DSR', 'icon': Icons.bar_chart},
  {'name': 'Staff Attendance', 'icon': Icons.person_add},
  {'name': 'DSR Exception', 'icon': Icons.description},
  {'name': 'Token Scan', 'icon': Icons.qr_code_scanner},
  {'name': 'Token Details', 'icon': Icons.list_alt},
];
