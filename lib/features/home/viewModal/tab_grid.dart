  import 'package:flutter/material.dart';
import 'package:sprash_arch/core/constants/theme.dart';
import 'package:sprash_arch/features/Screens/Notifications.dart';
import 'package:sprash_arch/features/Screens/dsr_Visit.dart';
import 'package:sprash_arch/features/Screens/exportPage.dart';
import 'package:sprash_arch/features/Screens/salesDashboard.dart';
import 'package:sprash_arch/features/home/models/home_modal.dart';

// function to build the grid for a given tab index
Widget buildGridForTab(int tabIndex, BuildContext context) {
    final AppTheme appTheme = AppTheme();
    List<GridItem> items = [];

    switch (tabIndex) {
      case 0: // Quick Menu
        items = [
          GridItem(
            icon: Icons.store,
            title: 'RPL Outlet Tracker',
            color: appTheme.primaryColor,
          ),
          GridItem(
            icon: Icons.assignment,
            title: 'DKC Lead Entry',
            color: appTheme.primaryColor,
          ),
          GridItem(
            icon: Icons.summarize_sharp,
            title: 'Sales Summary',
            color: appTheme.primaryColor,
          ),
          GridItem(
            icon: Icons.feedback,
            title: 'Training Feed Back',
            color: appTheme.primaryColor,
          ),
          GridItem(
            icon: Icons.dashboard,
            title: 'Sales Dashboard',
            color: appTheme.primaryColor,
          ),
          GridItem(
            icon: Icons.trending_up,
            title: 'Performance',
            color: appTheme.primaryColor,
          ),
          // ... Add other items similarly
        ];
        break;
      case 1: // Dashboard
        items = [
          GridItem(
            icon: Icons.dashboard,
            title: 'Sales Dashboard',
            color: appTheme.primaryColor,
          ),
          GridItem(
            icon: Icons.trending_up,
            title: 'Performance',
            color: appTheme.primaryColor,
          ),
          // ... Add other items similarly
        ];
        break;
      case 2: // Document
        items = [
          GridItem(
            icon: Icons.article,
            title: 'Recent Files',
            color: appTheme.primaryColor,
          ),
          GridItem(
            icon: Icons.cloud_upload,
            title: 'Upload Document',
            color: appTheme.primaryColor,
          ),
          // ... Add other items similarly
        ];
        break;
    }

    return Padding(
      padding: EdgeInsets.all(appTheme.spacing.medium),
      child: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: appTheme.spacing.xsmall,
        mainAxisSpacing: appTheme.spacing.xsmall,
        childAspectRatio: .72,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: items.map((item) => buildGridItem(item, context)).toList(),
      ),
    );
  }

  // Function to build a single grid item for the grid view
  Widget buildGridItem(GridItem item, BuildContext context) {
    final AppTheme appTheme = AppTheme();

    return GestureDetector(
      onTap: () {
        if (item.title == "RPL Outlet Tracker") {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const RetailerRegistrationApp(),
          //   ),
          // );
        } else if (item.title == "DKC Lead Entry") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Excelpage()),
          );
        }  else if (item.title == "Training Feed Back") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DSR()),
          );
        } else if (item.title == "Performance") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationsScreen()),
          );
        }else if (item.title == 'Sales Dashboard') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SalesSummaryPage()),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(appTheme.spacing.small),
            decoration: BoxDecoration(
              color: appTheme.surfaceColor,
              borderRadius: BorderRadius.circular(appTheme.cardBorderRadius),
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 1)],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(item.icon, color: item.color, size: 28)],
            ),
          ),
          SizedBox(height: appTheme.spacing.small),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: appTheme.fontSizes.xsmall,
              color: appTheme.textColor,
            ),
          ),
        ],
      ),
    );
  }


//   the  title of the tabs in the tab bar
//List<String> tabTitles = ["Quick Menu", "Dashboard", "Document"];
Widget gradientTextContainer({
  required String text,
  TextStyle? textStyle,
  double? padding,
}) {
  return Container(
    height: 30,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(10),
    topRight: Radius.circular(10),
  ),
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color.fromARGB(
            (0.8 * 255).round(),
            0,
            157,
            255,
          ),
          Color.fromARGB(255, 46, 55, 234),
        ],
        stops: const [0.0, 1.0],
      ),
    ),
    width: double.maxFinite,
    padding: EdgeInsets.symmetric(horizontal: padding?? 12.0, vertical: 2.0),
    child: Text(
      text,
      style: textStyle ??
          TextStyle(
            //  fontSize: appTheme.titleLarge?.fontSize ?? 20.0,  //  Accessing appTheme here is problematic
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
    ),
  );
}



// Widget for the tab selector at the top 
Widget tabSelector({
  required BuildContext context,
  required List<String> tabTitles,
  required int selectedTabIndex,
  required ValueChanged<int> onTabSelected,
}) {
  final appTheme = AppTheme();

  return Container(
    width: double.infinity, // Take up full width
    height: 50,
    padding: EdgeInsets.only(
        top: appTheme.spacing.small, bottom: appTheme.spacing.small),
    decoration: BoxDecoration(
      color: appTheme.surfaceColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: ListView( 
      // Changed to Row - SingleChildScrollView is in the caller if needed
      scrollDirection: Axis.horizontal,
      children: List.generate(
        tabTitles.length,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: appTheme.spacing.xsmall),
            child: ElevatedButton(
              onPressed: () {
                onTabSelected(index);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedTabIndex == index
                    ? appTheme.primaryLightColor
                    : appTheme.surfaceColor,
                foregroundColor: selectedTabIndex == index
                    ? appTheme.onPrimaryColor
                    : appTheme.primaryLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    appTheme.buttonBorderRadius,
                  ),
                  side: BorderSide(
                    color: selectedTabIndex == index
                        ? appTheme.primaryColor
                        : appTheme.neutralColor,
                  ),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
              ),
              child: Text(
                tabTitles[index],
                style: TextStyle(fontSize: appTheme.fontSizes.small),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}