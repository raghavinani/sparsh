import 'package:flutter/material.dart';
import 'package:sprash_arch/features/Banner/bannerLogin.dart';
import 'package:sprash_arch/features/Carousal/carousal.dart';
import 'package:sprash_arch/features/Sidebar/View/side_bar.dart';
import 'package:sprash_arch/features/bottombar/bottombar_widget.dart';
import 'package:sprash_arch/features/home/models/home_modal.dart';
import 'package:sprash_arch/features/home/view/home_tabs.dart';
import 'package:sprash_arch/features/home/view/mostused.dart';
import 'package:sprash_arch/features/home/viewModal/tab_grid.dart';

import '../../Appbar/top_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       extendBody: true,
       appBar: CustomAppBar(),
        drawer: CustomSidebar(),
        bottomNavigationBar: customBottomNavigationBar(
        onChangePage: (index) {
          print('Selected index: $index');
        },
      ),
      body: GestureDetector(
  onHorizontalDragEnd: (details) {
    if (details.primaryVelocity! > 0) {
      Navigator.of(context).pop();
    }
  },
  child: Stack(
    children: [
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
              child: const CustomCarousel(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: MostlyUsedApps(apps: appData),
            ),
            const SizedBox(height: 18),
            Container(
                decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black45,
                    width: 0.5,
                  ),
                  bottom: BorderSide(
                    color: Colors.black45,
                    width: 0.5,
                  ),
                ),
              ),
              child: tabSelector(
                context: context,
                tabTitles: tabTitles,
                selectedTabIndex: selectedTabIndex,
                onTabSelected: (index) {
                  setState(() {
                    selectedTabIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: HomeTabs(selectedTabIndex),
            ),


            
          ],
        )
      ),

            LoginBanner(),
          
             ],
  ),
),
    );
    
         
    
  }
}