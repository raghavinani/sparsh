import 'package:flutter/material.dart';
import 'package:sparsh/core/constants/theme.dart';
import 'package:sparsh/features/Screens/dsr_Visit.dart';
import 'package:sparsh/features/Tokens/view/token_detail.dart';
import 'package:sparsh/features/Tokens/view/token_scan.dart';
import 'package:sparsh/features/home/viewModal/tab_grid.dart';

class MostlyUsedApps extends StatelessWidget {
  final List<Map<String, dynamic>> apps;

  MostlyUsedApps({super.key, required this.apps});

  final AppTheme appTheme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: appTheme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 1)],
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Calculate available width
          double availableWidth = constraints.maxWidth;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gradientTextContainer(
                text: 'Mostly Used Apps',
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                padding: appTheme.spacing.medium,
              ),
              SizedBox(height: 12.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(top: 4.0),
                child: Wrap(
                  spacing:
                      availableWidth > 600
                          ? 20.0
                          : 10.0, // Adjust spacing based on screen width
                  runSpacing: 0.0,
                  children:
                      apps.map((app) {
                        return _buildAppItem(app, context, availableWidth);
                      }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppItem(
    Map<String, dynamic> app,
    BuildContext context,
    double availableWidth,
  ) {
    // Calculate item width based on available width
    double itemWidth = availableWidth > 600 ? 100.0 : 80.0;
    double iconSize = availableWidth > 600 ? 40.0 : 30.0; // Adjust icon size
    double fontSize = availableWidth > 600 ? 12.0 : 10.0; // Adjust font size

    return GestureDetector(
      onTap: () {
        if (app['name'] == "DSR") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DSRvisit()),
          );
        }
        // if (app['name'] == "Staff Attendance") {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => BulkAttendanceEntry(attendEntryData: attendEntrydata),
        //     ),
        //   );
        // }
        else if (app['name'] == "Token Scan") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TokenScanPage()),
          );
        } else if (app['name'] == "Token Details") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TokenDetailsPage()),
          );
        }
      },
      child: SizedBox(
        width: itemWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(appTheme.spacing.small),
              decoration: BoxDecoration(
                color: appTheme.surfaceColor,
                borderRadius: BorderRadius.circular(appTheme.cardBorderRadius),
                boxShadow: [BoxShadow(color: Colors.black, blurRadius: 1)],
              ),
              child: Icon(
                app['icon'],
                size: iconSize,
                color: AppTheme().primaryColor,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              app['name'],
              style: TextStyle(fontSize: fontSize),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
