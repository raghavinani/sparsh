import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprash_arch/DataLayer/services/logout_service.dart';
import 'package:sprash_arch/features/bottombar/bottombar_widget.dart';
import 'package:sprash_arch/features/home/view/home_page.dart';

import '../../widgets/custom_fields.dart';

class ProfilePage2 extends StatelessWidget {
  const ProfilePage2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('My Profile', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: customBottomNavigationBar(
        context: context,
        currentIndex: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(32.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/profile_image.png',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Raghav Inani',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        'ID  S2948',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Text(
                        'IT Department',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.edit, color: Colors.black),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _sectionTitle('Account Info'),
                  buildTextField(label: 'Username*'),
                  buildTextField(label: 'Email Address*'),
                  buildNumberField(label: 'Phone Number*'),
                  _sectionTitle('Dashboard Report'),
                  buildDropdownField(
                    label: 'Select Report*',
                    items: ['Sales Summary', 'DSR Visit', 'Token Scan'],
                  ),
                  _sectionTitle('Personal Info'),
                  buildDropdownField(
                    label: 'Gender*',
                    items: ['Male', 'Female', 'Other'],
                  ),
                  buildTextField(label: 'Address*'),

                  Consumer(
                    builder: (context, ref, child) {
                      return gradientbutton(
                        text: "Logout",
                        onPressed: () async {
                          await _logoutcheck(context, ref);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _infoPlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}

Future _logoutcheck(BuildContext context, WidgetRef ref) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final logoutService = ref.read(logoutServiceProvider);
              logoutService.logout(context, ref);
            },

            child: Text('Logout'),
          ),
        ],
      );
    },
  );
}
