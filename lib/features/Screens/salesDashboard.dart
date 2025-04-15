import 'package:flutter/material.dart';


class SalesSummaryPage extends StatefulWidget {
  const SalesSummaryPage({super.key});

  @override
  _SalesSummaryPageState createState() => _SalesSummaryPageState();
}

class _SalesSummaryPageState extends State<SalesSummaryPage> {
  String selectedCategory = 'White Cement (Trade)'; // Default selection
  final ScrollController _scrollController = ScrollController();

  List<String> categories = [
    'White Cement (Trade)',
    'White Cement (Non-Trade)',
    'White Cement (Total)',
    'Wall Care Putty (Trade)',
    'Wall Care Putty (Non-Trade)',
    'Wall Care Putty (Total)',
    'VAP (Trade)',
    'VAP (Non-Trade)',
    'VAP (Total)',
    'All Products (Trade)',
    'All Products (Non-Trade)',
    'All Products (Total)',
    'Liquid Paint Primer (Trade)',
    'Liquid Paint Primer (Non-Trade)',
    'Liquid Paint Primer (Total)',
    'Distemper (Trade)',
    'Distemper (Non-Trade)',
    'Distemper (Total)',
    'Seep Guard (Trade)',
    'Seep Guard (Non-Trade)',
    'Seep Guard (Total)',
    'Gypsum (Trade)',
    'Gypsum (Non-Trade)',
    'Gypsum (Total)',
    'Tile Adhesive (Trade)',
    'Tile Adhesive (Non-Trade)',
    'Tile Adhesive (Total)',
    'TileLynk (Trade)',
    'TileLynk (Non-Trade)',
    'TileLynk (Total)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Summary'),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReportSelection(context),
            SizedBox(height: 8),
            _buildZoneSummary(context),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildReportSelection(BuildContext context) {
    double cardWidth =
        MediaQuery.of(context).size.width * 0.6; // 60% of screen width

    return Container(
      width: double.infinity, // Full width container
      padding: EdgeInsets.symmetric(vertical: 12),
      color: Colors.lightBlueAccent,
      child: Column(
        children: [
          _buildReportCard('Summary', ['Zone', 'State', 'Area'], cardWidth),
          SizedBox(height: 12),
          _buildReportCard('SKU Wise', [
            'White Cement',
            'WCP',
            'VAP',
            'VAP (SKU Wise)',
          ], cardWidth),
          SizedBox(height: 12),
          _buildReportCard('Stock Report', ['Stock Report'], cardWidth),
        ],
      ),
    );
  }

  Widget _buildReportCard(String title, List<String> items, double width) {
    return Container(
      width: width, // Centered card width
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Table(
            border: TableBorder.all(
              color: Colors.grey[400]!,
              width: 1,
            ), // Outlined border for table
            columnWidths: {0: FlexColumnWidth()}, // Single column full width
            children:
                items
                    .map(
                      (item) => TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            child: Text(item, style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildZoneSummary(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 100),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Zone Wise Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'YTD : Year To Date (from 01-Apr-2022 To 09-Feb-2023)',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              Text(
                'MTD : Month To Date (from 01-Feb-2023 To 09-Feb-2023)',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              Text(
                'MOM : Month on Month (Compare with last Month)',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 50),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildCategorySelection(),
                Divider(color: Colors.grey[400]!, thickness: 0.8),
                _buildTable(selectedCategory),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelection() {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children:
          categories.map((category) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
              },
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      selectedCategory == category
                          ? FontWeight.bold
                          : FontWeight.normal,
                  color:
                      selectedCategory == category ? Colors.blue : Colors.red,
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildTable(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Scrollbar(
          // Wrap the horizontal scroll with Scrollbar
          controller: _scrollController,
          thumbVisibility: true, // Ensures scrollbar is visible
          trackVisibility: true, // Show track along scrollbar
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController, // Attach the scroll controller
            child: DataTable(
              headingRowColor: WidgetStateColor.resolveWith(
                (states) => Colors.grey[300]!,
              ),
              border: TableBorder(
                horizontalInside: BorderSide(
                  color: Colors.black54,
                  width: 0.7,
                ), // Divider between rows
                verticalInside: BorderSide(
                  color: Colors.black54,
                  width: 0.7,
                ), // Divider between columns
              ),
              columns: [
                DataColumn(
                  label: Text(
                    'Zone',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'CYTD Sale',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'LYTD Sale',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'CY MTD',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'LY MTD',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Previous Day Sale',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'MOM Sale (Jan 2023)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'YTD Delta',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'MTD Delta',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'MOM Delta',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Month SnOP',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Month SnOP Ach%',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: [
                _buildDataRow(
                  'Central',
                  '53354',
                  '52234',
                  '1922',
                  '1508',
                  '272',
                  '1076',
                  '1120',
                  '414',
                  '845',
                  '7762',
                  '25',
                ),
                _buildDataRow(
                  'East',
                  '25461',
                  '23004',
                  '1093',
                  '658',
                  '125',
                  '527',
                  '2457',
                  '435',
                  '566',
                  '3359',
                  '33',
                ),
                _buildDataRow(
                  'North',
                  '46161',
                  '42685',
                  '1174',
                  '934',
                  '131',
                  '1226',
                  '3476',
                  '240',
                  '-52',
                  '6167',
                  '19',
                ),
                _buildDataRow(
                  'South',
                  '76379',
                  '73640',
                  '2064',
                  '2088',
                  '355',
                  '1889',
                  '2739',
                  '-24',
                  '175',
                  '9210',
                  '22',
                ),
                _buildDataRow(
                  'West',
                  '53255',
                  '51008',
                  '1465',
                  '1385',
                  '242',
                  '968',
                  '2246',
                  '80',
                  '496',
                  '6609',
                  '22',
                ),
                _buildDataRow(
                  'Export Int.',
                  '64',
                  '58',
                  '-',
                  '-',
                  '-',
                  '-',
                  '6',
                  '-',
                  '-',
                  '-',
                  '-',
                ),
                _buildDataRow(
                  'Export Nepal',
                  '911',
                  '1490',
                  '27',
                  '-',
                  '-',
                  '81',
                  '-579',
                  '27',
                  '-54',
                  '197',
                  '14',
                ),
                _buildDataRow(
                  'Grand Total',
                  '255584',
                  '244120',
                  '7744',
                  '6572',
                  '1125',
                  '5767',
                  '11465',
                  '1172',
                  '1977',
                  '33304',
                  '23',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  DataRow _buildDataRow(
    String zone,
    String cytd,
    String lytd,
    String cymtd,
    String lymtd,
    String pds,
    String moms,
    String ytd,
    String mtd,
    String momd,
    String msnop,
    String msnopach,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(zone)),
        DataCell(Text(cytd)),
        DataCell(Text(lytd)),
        DataCell(Text(cymtd)),
        DataCell(Text(lymtd)),
        DataCell(Text(pds)),
        DataCell(Text(moms)),
        DataCell(Text(ytd)),
        DataCell(Text(mtd)),
        DataCell(Text(momd)),
        DataCell(Text(msnop)),
        DataCell(Text(msnopach)),
      ],
    );
  }
}
