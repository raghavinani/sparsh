import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprash_arch/features/Appbar/top_appbar.dart';
import 'package:sprash_arch/features/Sidebar/View/side_bar.dart';

import 'token_detail.dart';
import 'token_summary.dart';

class TokenReportScreen extends StatefulWidget {
  final String activeTab;
  const TokenReportScreen({super.key, this.activeTab = 'Report'});
  @override
  _TokenReportScreenState createState() => _TokenReportScreenState();
}

class _TokenReportScreenState extends State<TokenReportScreen> {
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate =
        isStartDate ? startDate ?? DateTime.now() : endDate ?? DateTime.now();
    DateTime firstDate = DateTime(2020);
    DateTime lastDate = DateTime(2030);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomSidebar(),
      body: Column(
        children: [
          _buildTopNav(context, widget.activeTab),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Token Scan Details Confidential",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade300, blurRadius: 6),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Date Pickers Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Start Date
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Start Date",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => _selectDate(context, true),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          startDate != null
                                              ? DateFormat(
                                                "dd/MM/yyyy",
                                              ).format(startDate!)
                                              : "Select Date",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),

                            // End Date
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "End Date",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => _selectDate(context, false),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          endDate != null
                                              ? DateFormat(
                                                "dd/MM/yyyy",
                                              ).format(endDate!)
                                              : "Select Date",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        // Check Now & Date Info Row
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: Implement check logic
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Text(
                                "Check Now",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // // Date Info
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     Text(
                        //       "At Date: ${startDate != null ? DateFormat("dd/MM/yyyy").format(startDate!) : '--/--/----'}",
                        //       style: TextStyle(fontSize: 14),
                        //     ),
                        //     Text(
                        //       "To Date: ${endDate != null ? DateFormat("dd/MM/yyyy").format(endDate!) : '--/--/----'}",
                        //       style: TextStyle(fontSize: 14),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Category Header
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.grey[700],
                      child: Text(
                        "Category",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),

                  // Category List Placeholder
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView(
                        children: [
                          ListTile(title: Text("Sample Category 1")),
                          Divider(),
                          ListTile(title: Text("Sample Category 2")),
                          Divider(),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Close Button
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopNav(BuildContext context, String activeTab) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ), // Add padding outside the border
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(
              context,
              'Details',
              activeTab == 'Details',
              const TokenDetailsPage(activeTab: 'Details'),
            ),
            _navItem(
              context,
              'Report',
              activeTab == 'Report',
              const TokenReportScreen(activeTab: 'Report'),
            ),
            _navItem(
              context,
              'Summary',
              activeTab == 'Summary',
              const TokenSummaryScreen(activeTab: 'Summary'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    String label,
    bool isActive,
    Widget targetPage,
  ) {
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => targetPage),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ), // Add padding
        decoration: BoxDecoration(
          color:
              isActive
                  ? Color.fromRGBO(0, 112, 183, 1)
                  : Colors.transparent, // Background color
          borderRadius: BorderRadius.circular(8), // Optional: rounded corners
        ),
        child: Text(
          label,
          style: TextStyle(
            color:
                isActive
                    ? Colors.white
                    : Colors.black, // White text when active
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
