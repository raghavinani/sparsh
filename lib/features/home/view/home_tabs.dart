import 'package:flutter/material.dart';
import 'package:sparsh/core/constants/theme.dart';
import 'package:sparsh/features/home/models/home_modal.dart';
import 'package:sparsh/features/home/viewModal/tab_grid.dart';

class HomeTabs extends StatefulWidget {
  const HomeTabs(int selectedTabIndex, {super.key});

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = AppTheme();

    return SafeArea(
      child: Flexible(
        fit: FlexFit.loose, // Use Flexible with FlexFit.loose
        child: Container(
          decoration: BoxDecoration(
            color: appTheme.backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 1)],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                gradientTextContainer(
                  text: tabTitles[selectedTabIndex],
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  padding: appTheme.spacing.medium,
                ),
                SizedBox(child: buildGridForTab(selectedTabIndex, context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
