import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparsh/core/constants/theme.dart';
import 'package:sparsh/features/Screens/dsr_Visit.dart';
import 'package:sparsh/features/Tokens/view/token_detail.dart';
import 'package:sparsh/features/Login/viewModal/login_viewmodal.dart';

import '../../../DataLayer/modals/role_menu_data.dart';
import '../../Appbar/Modals/menu_model.dart';

class CustomSidebar extends ConsumerStatefulWidget {
  const CustomSidebar({super.key});

  @override
  ConsumerState<CustomSidebar> createState() => _CustomSidebarState();
}

class _CustomSidebarState extends ConsumerState<CustomSidebar> {
  Map<String, bool> expandedSections = {
    'Transactions': false,
    'Reports': false,
    'Masters': false,
    'Miscellaneous': false,
  };
  var apptheme = AppTheme();
  RoleMenu? _menuData;
  String? selectedMenuItem;
  String? selectedSubMenuItem;
  String? expandedTitle;
  final loginViewModelProvider = Provider((ref) => LoginViewModel(ref));

  @override
  void initState() {
    super.initState();
    initializeMenuData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update menu data when role changes
    final userRole = ref.watch(
      loginViewModelProvider.select(
        (provider) => provider.loginuserRoleProvider,
      ),
    );
    if (_menuData == null || _menuData?.roleName != userRole) {
      setState(() {
        _menuData = menuData[userRole.toString()] ?? menuData['admin']!;
      });
    }
  }

  void initializeMenuData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final userRole = ref.read(
          loginViewModelProvider.select(
            (provider) => provider.loginuserRoleProvider,
          ),
        );
        setState(() {
          _menuData =
              menuData[userRole.toString()] ?? menuData['admin']!; //default
        });
      }
    });
  }

  void handleMenuItemSelection(String title) {
    setState(() {
      // Reset all menu items
      _menuData?.transactionLinks.forEach((item) => item.isSelected = false);
      _menuData?.reportLinks.forEach((item) => item.isSelected = false);
      _menuData?.masterLinks.forEach((item) => item.isSelected = false);

      // Set selected item
      _menuData
          ?.transactionLinks
          .firstWhere(
            (item) => item.title == title,
            orElse: () => MenuItem(title: '', subLinks: []),
          )
          .isSelected = true;
      _menuData
          ?.reportLinks
          .firstWhere(
            (item) => item.title == title,
            orElse: () => MenuItem(title: '', subLinks: []),
          )
          .isSelected = true;
      _menuData
          ?.masterLinks
          .firstWhere(
            (item) => item.title == title,
            orElse: () => MenuItem(title: '', subLinks: []),
          )
          .isSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Return a loading indicator if menu data is not yet initialized
    if (_menuData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            child: SizedBox(
              width: screenWidth * 0.7,
              child: Drawer(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 90,
                          decoration: BoxDecoration(
                            color: apptheme.primaryColor,
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/logo.jpeg",
                            height: 70,
                            width: 140,
                            fit: BoxFit.fill,
                          ),
                        ),
                        _buildCollapsibleMenu(
                          'Transactions',
                          _menuData!.transactionLinks,
                          Icons.receipt_long,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            color: apptheme.primaryColor,
                            thickness: 0.8,
                          ),
                        ),
                        _buildCollapsibleMenu(
                          'Reports',
                          _menuData!.reportLinks,
                          Icons.insert_chart,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            color: apptheme.primaryColor,
                            thickness: 0.8,
                          ),
                        ),
                        _buildCollapsibleMenu(
                          'Masters',
                          _menuData!.masterLinks,
                          Icons.settings_applications,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            color: apptheme.primaryColor,
                            thickness: 0.8,
                          ),
                        ),
                        _buildCollapsibleMenu(
                          'Miscellaneous',
                          _menuData!.miscLinks
                              .map(
                                (link) => MenuItem(title: link, subLinks: []),
                              )
                              .toList(),
                          Icons.more_horiz,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            color: apptheme.primaryColor,
                            thickness: 0.8,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsibleMenu(
    String title,
    List<MenuItem> links,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                expandedSections[title] = !(expandedSections[title] ?? false);
                expandedTitle = expandedSections[title]! ? title : null;
                selectedMenuItem = title;
                selectedSubMenuItem = null;
              });
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              color:
                  selectedMenuItem == title
                      ? const Color.fromRGBO(0, 112, 183, 0.1)
                      : Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    icon,
                    color:
                        selectedMenuItem == title
                            ? const Color.fromRGBO(0, 112, 183, 1)
                            : Colors.black,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color:
                            selectedMenuItem == title
                                ? const Color.fromRGBO(0, 112, 183, 1)
                                : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Icon(
                    expandedSections[title]!
                        ? Icons.expand_less
                        : Icons.expand_more,
                    // color:
                    //     expandedTitle == title
                    //         ? const Color.fromRGBO(0, 112, 183, 1)
                    //         : Colors.black,
                    size: 14,
                  ),
                ],
              ),
            ),
          ),
          if (expandedSections[title]!)
            Column(
              children:
                  links
                      .map((link) => _buildSubMenuItem(context, link))
                      .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildSubMenuItem(BuildContext context, MenuItem link) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: PopupMenuButton<String>(
        offset: const Offset(280, 0),
        onOpened: () {
          setState(() {
            selectedSubMenuItem = link.title;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
          ), // Shift submenu items slightly right
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                link.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color:
                      selectedSubMenuItem == link.title
                          ? Colors.blue[700]
                          : Colors.black,
                ),
              ),
              Icon(
                Icons.arrow_right,
                size: 14,
                color: link.isSelected ? Colors.blue[700] : Colors.black,
              ),
            ],
          ),
        ),
        onSelected: (value) {
          handleMenuItemSelection(link.title);
          if (value == 'Rural Retailer Entry/Update') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DSR()),
            );
          } else if (value == 'Token Scan') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TokenDetailsPage()),
            );
            // } else if (value == 'Order Update') {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => const OrderUpdate()),
            //   );
          }
        },
        itemBuilder:
            (context) =>
                link.subLinks
                    .map<PopupMenuItem<String>>(
                      (subLink) => PopupMenuItem<String>(
                        value: subLink,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            '• $subLink',
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14.0,
                              color: Color.fromARGB(255, 2, 27, 48),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
      ),
    );
  }
}
