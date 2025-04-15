import 'package:flutter/material.dart';
import 'package:sprash_arch/core/constants/theme.dart';



class StatusColorWidget extends StatelessWidget {
  final String status;
  const StatusColorWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(
      status,
    ); // Call the color determination function
    var theme = AppTheme();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.medium,
        vertical: theme.spacing.small,
      ),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(theme.radius.medium),
          bottomLeft: Radius.circular(theme.radius.medium),
        ),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Function to determine status color based on status string (private to this file)
  static Color _getStatusColor(String status) {
    if (status == 'Completed') {
      return Colors.green;
    } else if (status == 'Cancelled') {
      return Colors.red;
    } else {
      return Colors.orange; // For "In Progress" and other statuses
    }
  }
}
