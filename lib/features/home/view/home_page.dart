import 'package:flutter/material.dart';
import 'package:sparsh/features/Banner/bannerLogin.dart';
import 'package:sparsh/features/Carousal/carousal.dart';
import 'package:sparsh/features/Sidebar/View/side_bar.dart';
import 'package:sparsh/features/bottombar/bottombar_widget.dart';
import 'package:sparsh/features/home/models/home_modal.dart';
import 'package:sparsh/features/home/view/home_tabs.dart';
import 'package:sparsh/features/home/view/mostused.dart';
import 'package:sparsh/features/home/viewModal/tab_grid.dart';

import '../../Appbar/top_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isBannerVisible = false;

  void _onBannerVisibilityChanged(bool isVisible) {
    setState(() {
      _isBannerVisible = isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 230, 230),
      extendBody: true,
      appBar: _isBannerVisible ? null : CustomAppBar(),
      drawer: _isBannerVisible ? null : CustomSidebar(),
      bottomNavigationBar:
          _isBannerVisible
              ? null
              : customBottomNavigationBar(context: context, currentIndex: 3),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0 && !_isBannerVisible) {
            Navigator.of(context).pop();
          }
        },
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: _isBannerVisible, // disables interaction
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: CustomCarousel(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: MostlyUsedApps(apps: appData),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.black45, width: 0.5),
                          bottom: BorderSide(color: Colors.black45, width: 0.5),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: HomeTabs(selectedTabIndex),
                    ),
                  ],
                ),
              ),
            ),

            /// Place the banner and pass the visibility callback
            LoginBanner(onVisibilityChanged: _onBannerVisibilityChanged),
          ],
        ),
      ),
    );
  }
}
