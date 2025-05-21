// import 'package:flutter/material.dart';
// import 'package:sparsh/features/Appbar/Modals/app_links.dart';

// import '../../../DataLayer/modals/role_menu_data.dart';
// import '../../../DataLayer/modals/role_menu_model.dart';
// import '../../Appbar/Modals/app_links.dart';


// String? selectedMenuItem;
//   String? selectedSubMenuItem;
//   String? expandedTitle;
// void handleMenuItemSelection(String title) {
//     setState(() {
//       selectedMenuItem = title;
//       // Reset all menu items
//       menuData?.transactionLinks.forEach((item) => item.isSelected = false);
//       menuData?.reportLinks.forEach((item) => item.isSelected = false);
//       menuData?.masterLinks.forEach((item) => item.isSelected = false);

//       // Set selected item
//       menuData
//           ?.transactionLinks
//           .firstWhere(
//             (item) => item.title == title,
//             orElse: () => MenuItem(title: '', subLinks: []),
//           )
//           .isSelected = true;
//       menuData
//           ?.reportLinks
//           .firstWhere(
//             (item) => item.title == title,
//             orElse: () => MenuItem(title: '', subLinks: []),
//           )
//           .isSelected = true;
//       menuData
//           ?.masterLinks
//           .firstWhere(
//             (item) => item.title == title,
//             orElse: () => MenuItem(title: '', subLinks: []),
//           )
//           .isSelected = true;
//     });
//   }

//   void handleSubMenuItemSelection(String subLink) {
//     setState(() {
//       selectedSubMenuItem = subLink;
//     });
//   }