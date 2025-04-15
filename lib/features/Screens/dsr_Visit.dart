import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:sprash_arch/features/bottombar/bottombar_widget.dart';
import 'package:sprash_arch/features/home/view/home_page.dart';

void main() {
  runApp(const DSR());
}

class DSR extends StatelessWidget {
  const DSR({super.key});

  @override
  Widget build(BuildContext context) {
    return DSRvisit();
  }
}

class DSRvisit extends StatefulWidget {
  const DSRvisit({super.key});

  @override
  State<DSRvisit> createState() => _DSRvisitpageState();
}

class _DSRvisitpageState extends State<DSRvisit> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedOption;
  DateTime? _selectedDate;
  bool _isKYCEditable = false;

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 1080;
    return Scaffold(
      // appBar: CustomAppBar(),
      // drawer: CustomSidebar(),
      bottomNavigationBar: customBottomNavigationBar(onChangePage: (int value) {  }),

      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }
          }
        },
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 112, 183, 1),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 8), // Spacing between icon and text
                  const Text(
                    'DSR Visit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text color
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            // The form below will be scrollable
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isWideScreen
                          ? Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: _buildBasicDetailsForm()),
                                  const SizedBox(width: 8.0),
                                  Expanded(child: _buildKYCDetailsForm()),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: _buildEnrolmentSlabForm()),
                                  const SizedBox(width: 8.0),
                                  Expanded(child: _buildBrandsInfoForm()),
                                ],
                              ),
                            ],
                          )
                          : Column(
                            children: [
                              _buildBasicDetailsForm(),
                              const SizedBox(height: 16.0),
                              _buildKYCDetailsForm(),
                              const SizedBox(height: 16.0),
                              _buildEnrolmentSlabForm(),
                              const SizedBox(height: 16.0),
                              _buildBrandsInfoForm(),
                            ],
                          ),
                      const SizedBox(height: 16.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Form Submitted Successfully!'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                            backgroundColor: Colors.blueAccent,
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicDetailsForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Basic Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 112, 183, 1),
            ),
          ),
          const SizedBox(height: 8.0),
          _buildClickableOptions('Process Type*', ['Add', 'Update', 'Delete']),
          _buildDropdownField('Document Number*', [
            'DOC001',
            'DOC002',
            'DOC003',
          ]),
          _buildDropdownField('Purchaser / Retailer', [
            'Purchaser',
            'Retailer',
          ]),
          _buildDropdownField('Area Code*', ['560038', '100012']),
          _buildTextField('Code'),
          _buildTextField('Name'),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Click Here to Edit KYC',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isKYCEditable = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                ),
                child: const Text(
                  'Edit KYC',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget _buildKYCDetailsForm() {
    return Opacity(
      opacity: _isKYCEditable ? 1.0 : 0.5, // Dull effect when not editable
      child: AbsorbPointer(
        absorbing: !_isKYCEditable, // Disable editing when not active
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 112, 183, 1),
                ),
              ),
              const SizedBox(height: 8.0),
              _buildDropdownField('KYC Status', [
                'Complete',
                'Pending',
                'Yet to Start',
              ]),
              _buildDateField('Report Date*'),
              _buildTextField('Market Name (Location or Name)*'),
              _buildClickableOptions('Participation of Display Contest*', [
                'Yes',
                'NO',
                'NA',
              ]),
              _buildClickableOptions('Any Pending Issues (Yes / No)*', [
                'Yes',
                'NO',
              ]),
              _buildDropdownField('If Yes, Pending Issue Details', [
                'option 1',
                'option 2',
                'option 3',
              ]),
              _buildTextField('If Yes, Specify Issue'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnrolmentSlabForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enrolment Slab (in MT)*',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 112, 183, 1),
            ),
          ),
          const SizedBox(height: 4.0),
          _buildNumberField('WC'),
          _buildNumberField('WCP'),
          _buildNumberField('VAP'),
          const SizedBox(height: 8.0),
          const Text(
            'BW Stocks Availability (in MT)*',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 112, 183, 1),
            ),
          ),
          const SizedBox(height: 4.0),
          _buildNumberField('WC'),
          _buildNumberField('WCP'),
          _buildNumberField('VAP'),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget _buildBrandsInfoForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text(
          //   'Brands Selling - WC(Industry Volume) (in MT)*',
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //     color: Color.fromRGBO(0, 112, 183, 1),
          //   ),
          // ),
          _buildClickableOptions("Brands Selling - WC(Industry Volume)", [
            'BW',
            'JK',
            'RAK',
            'Other',
          ]),
          _buildNumberField("WC(Industry Volume) (in MT)"),
          const SizedBox(height: 8.0),
          _buildClickableOptions("Brands Selling - WCP(Industry Volume)", [
            'BW',
            'JK',
            'Berger',
            'Aerocon',
            'Paint Major',
            'Asian Paints',
            'Other',
          ]),
          _buildNumberField("WCP Industry Volume (in MT)"),
        ],
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40, // Increased height for better visibility
          child: TextFormField(
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              labelText: label, // Label inside the field
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              floatingLabelBehavior:
                  FloatingLabelBehavior.auto, // Moves label above when typing
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: (value) {
              if (label.endsWith('*') && (value == null || value.isEmpty)) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildNumberField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40, // Ensuring proper height
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              labelText: label, // Label inside the field
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              floatingLabelBehavior:
                  FloatingLabelBehavior.auto, // Moves label above when typing
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: (value) {
              if (label.endsWith('*') && (value == null || value.isEmpty)) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildDateField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: TextFormField(
            readOnly: true,
            controller: TextEditingController(
              text:
                  _selectedDate != null
                      ? '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}'
                      : '',
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  _selectedDate = pickedDate;
                });
              }
            },
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              labelText: label, // Floating label
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              floatingLabelBehavior:
                  FloatingLabelBehavior.auto, // Moves label above when filled
              suffixIcon: const Icon(
                Icons.calendar_today,
                size: 18,
              ), // Calendar icon
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: (value) {
              if (label.endsWith('*') && (value == null || value.isEmpty)) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: DropdownButtonFormField<String>(
            style: const TextStyle(fontSize: 14, color: Colors.black),
            dropdownColor: Colors.white,
            items:
                items
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: const TextStyle(fontSize: 14)),
                      ),
                    )
                    .toList(),
            onChanged: (value) {},
            decoration: InputDecoration(
              labelText: label, // Floating label
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              floatingLabelBehavior:
                  FloatingLabelBehavior.auto, // Moves label above when selected
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: (value) {
              if (label.endsWith('*') && value == null) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildClickableOptions(String label, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 2.0),
        Wrap(
          spacing: 8.0, // Adjust spacing between chips if needed
          runSpacing: 8.0, // Adjust spacing between rows if needed
          children:
              options.map((option) {
                final isSelected = _selectedOption == option;
                return ChoiceChip(
                  label: Text(option),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedOption = selected ? option : null;
                    });
                  },
                  labelStyle:
                      isSelected
                          ? TextStyle(color: Colors.white)
                          : TextStyle(color: Colors.black),
                  backgroundColor: Colors.white,
                  selectedColor: const Color.fromRGBO(0, 112, 183, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Circular shape
                    side: BorderSide(
                      color: const Color.fromRGBO(
                        0,
                        112,
                        183,
                        1,
                      ), // Optional border
                    ),
                  ),
                );
              }).toList(),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
