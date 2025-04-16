import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
Widget buildTextField({
  required String label,
  Color? color,
  double? height,
  double? width,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width:
            width ?? double.infinity, // Default to full width if not provided
        child: TextFormField(
          style: const TextStyle(fontSize: 14),
          maxLines:
              height != null
                  ? (height ~/ 20)
                  : 1, // Approximate lines based on height
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            labelText: label, // Label inside the field
            alignLabelWithHint: true,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color,
            ),
            floatingLabelBehavior:
                FloatingLabelBehavior.auto, // Moves label above when typing
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8, // Adjusts padding based on height
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

Widget buildNumberField({required String label, Color? art}) {
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
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: art,
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

// Widget buildDateField(String label) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       SizedBox(
//         height: 40,
//         child: TextFormField(
//           readOnly: true,
//           controller: TextEditingController(
//             text:
//                 _selectedDate != null
//                     ? '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}'
//                     : '',
//           ),
//           onTap: () async {
//             DateTime? pickedDate = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2100),
//             );
//             if (pickedDate != null) {
//               setState(() {
//                 _selectedDate = pickedDate;
//               });
//             }
//           },
//           style: const TextStyle(fontSize: 14),
//           decoration: InputDecoration(
//             labelText: label, // Floating label
//             labelStyle: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//             floatingLabelBehavior:
//                 FloatingLabelBehavior.auto, // Moves label above when filled
//             suffixIcon: const Icon(
//               Icons.calendar_today,
//               size: 18,
//             ), // Calendar icon
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 8,
//               vertical: 4,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//           ),
//           validator: (value) {
//             if (label.endsWith('*') && (value == null || value.isEmpty)) {
//               return 'This field is required';
//             }
//             return null;
//           },
//         ),
//       ),
//       const SizedBox(height: 16.0),
//     ],
//   );
// }

Widget buildDropdownField({
  required String label,
  required List<String> items,
  Color? color,
}) {
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
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color,
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

Widget ElevatedButtonWidget({
  required String text,
  Color? color,
  double? width,
  double? height,
}) {
  return SizedBox(
    width: 85,
    height: 30,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    ),
  );
}


Widget gradientbutton({
  required String text,
  required VoidCallback onPressed,  // Added this parameter
  Color? color,
  double? width,
  double? height,
}) {
  return SizedBox(
    width: 120,
    height: 40,
    child: Container(
      decoration: BoxDecoration(
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
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,  // Using the passed callback here
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
