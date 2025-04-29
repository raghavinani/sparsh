
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprash_arch/DataLayer/modals/role_menu_data.dart';
import 'package:sprash_arch/core/constants/theme.dart';
import 'package:sprash_arch/features/Screens/Notifications.dart';
import 'package:sprash_arch/features/auth/viewModal/login_viewmodal.dart';

import '../home/view/home_page.dart';
import 'Modals/menu_model.dart';
import 'search.dart';


class CustomAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  bool isSearchActive = false;
  AppTheme appTheme = AppTheme();
  RoleMenu? _menuData;
  LoginViewModel? _loginViewModel;
final loginViewModelProvider = Provider((ref) => LoginViewModel(ref));
  @override
  void initState() {
    super.initState();
    _initializeMenuData();
  }

  void _initializeMenuData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _loginViewModel = ref.read( loginViewModelProvider);
      if (_loginViewModel == null) return;
      
      final userRole = ref.read(_loginViewModel!.userRoleProvider);
      if (userRole == null) return;
      
      setState(() {
        _menuData = menuData[userRole] ?? menuData['custm']!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double appBarHeight = isSearchActive ? 100 : 50;
     final showBanner = _loginViewModel != null ? ref.watch(_loginViewModel!.showBannerProvider) : false;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: appBarHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: const Icon(Icons.menu, color: Colors.black),
                      ),
                      Container(
                        height: 25,
                        width: 1.5,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        child: Text(
                          "SPARSH",
                          style: TextStyle(
                            color: AppTheme().primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (screenWidth > 1080)
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildDropdownMenu(
                                context,
                                'Transactions',
                                _menuData?.transactionLinks ?? [],
                              ),
                              _buildDropdownMenu(
                                context,
                                'Reports',
                                _menuData?.reportLinks ?? [],
                              ),
                              _buildDropdownMenu(
                                context,
                                'Masters',
                                _menuData?.masterLinks ?? [],
                              ),
                              _buildDropdownMenu(
                                context,
                                'Miscellaneous',
                                _menuData?.miscLinks
                                        .map(
                                          (link) => MenuItem(
                                            title: link,
                                            subLinks: [],
                                          ),
                                        )
                                        .toList() ??
                                    [],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_active_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationsScreen(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          isSearchActive = !isSearchActive;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (showBanner)
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 200),
                  firstChild: Container(height: 0),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 5,
                      left: 8,
                      right: 8,
                    ),
                    child: SearchBarWidget(),
                  ),
                  crossFadeState:
                      isSearchActive
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownMenu(
    BuildContext context,
    String title,
    List<MenuItem> links,
  ) {
    return PopupMenuButton<String>(
      tooltip: title,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      onSelected: (value) {
        _handleNavigation(context, value);
      },
      itemBuilder:
          (context) =>
              links.map((link) {
                return PopupMenuItem<String>(
                  value: link.title,
                  child: _buildSubMenu(context, link),
                );
              }).toList(),
    );
  }

  Widget _buildSubMenu(BuildContext context, MenuItem link) {
    return PopupMenuButton<String>(
      offset: const Offset(200, 0),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              link.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.arrow_right, size: 12),
            ),
          ],
        ),
      ),
      onSelected: (value) {
        _handleNavigation(context, value);
      },
      itemBuilder:
          (context) =>
              link.subLinks
                  .map<PopupMenuItem<String>>(
                    (subLink) => PopupMenuItem<String>(
                      value: subLink,
                      child: Text('• $subLink'),
                    ),
                  )
                  .toList(),
    );
  }

  void _handleNavigation(BuildContext context, String value) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$value clicked')));
  }
}
