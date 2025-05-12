import 'package:flutter/material.dart';
import 'package:sprash_arch/features/Appbar/top_appbar.dart';
import 'package:sprash_arch/features/Sidebar/View/side_bar.dart';
import 'package:sprash_arch/features/bottombar/bottombar_widget.dart';
import 'package:sprash_arch/features/widgets/custom_fields.dart';

class Excelpage extends StatefulWidget {
  const Excelpage({Key? key}) : super(key: key);

  @override
  State<Excelpage> createState() => _ExcelpageState();
}

class _ExcelpageState extends State<Excelpage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomSidebar(),
      bottomNavigationBar: customBottomNavigationBar(
        context: context,
        currentIndex: 2,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confidential',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Column(
                    children: [
                      const SizedBox(height: 20),

                      buildDropdownField(
                        label: "Select Report Type",
                        items: ["A", "B", "C", "D"],
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 8),
                      buildDropdownField(
                        label: "Output Type",
                        items: ["A", "B", "C", "D"],
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 8),
                      buildTextField(label: "Start Date", color: Colors.blue),
                      const SizedBox(height: 8),
                      buildTextField(label: "End Date", color: Colors.blue),
                      const SizedBox(height: 8),
                      buildTextField(
                        label: "Specific Codes (Seperated List)* ",
                        color: Colors.blue,
                        height: 80,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButtonWidget(text: 'Go', color: Colors.blue),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                ),
                                onPressed: () {},
                                child: FittedBox(child: Text('Copy')),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                ),
                                onPressed: () {},
                                child: FittedBox(child: Text('Excel')),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                ),
                                onPressed: () {},
                                child: FittedBox(child: Text('CSV')),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                ),
                                onPressed: () {},
                                child: FittedBox(child: Text('PDF')),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),
                      Container(
                        height: 200,
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            // Existing content
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Report will be displayed here',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            // View Data button
                            Positioned(
                              right: 8,
                              bottom: 8,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your view data logic here
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'View Data',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
