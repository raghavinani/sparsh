import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BulkAttendanceEntry extends StatefulWidget {
  final List<Map<String, String>> attendEntryData;

  const BulkAttendanceEntry({Key? key, required this.attendEntryData})
    : super(key: key);

  @override
  _BulkAttendanceEntryState createState() => _BulkAttendanceEntryState();
}

class _BulkAttendanceEntryState extends State<BulkAttendanceEntry> {
  final List<TextEditingController> remarkControllers = [];
  List<Map<String, dynamic>> processedData = [];
  final ScrollController _scrollController = ScrollController();

  final List<String> attendanceTypes = [
    'Present',
    'Week Off',
    'Holiday',
    'Company Holiday',
    'Leave',
    'Absent',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controllers and process data
    processedData =
        widget.attendEntryData.map((entry) {
          remarkControllers.add(TextEditingController(text: entry['atRemark']));
          return {
            ...entry,
            'atTyp1': entry['atTyp1'] ?? '',
            'atTyp2': entry['atTyp2'] ?? '',
            'dayOfWeek': DateFormat(
              'EEEE',
            ).format(DateTime.parse(entry['pnchDate'] ?? '')),
          };
        }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bulk Attendance Entry'),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: _saveAllEntries),
        ],
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue.shade100,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Date & Day',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Type 1',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Type 2',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Remarks',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          // List of entries
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: processedData.length,
              itemBuilder: (context, index) {
                final entry = processedData[index];
                final date = DateTime.parse(entry['pnchDate']);

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        // Date and Day
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('yyyy-MM-dd').format(date),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                entry['dayOfWeek'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Attendance Type 1
                        Expanded(
                          child: DropdownButton<String>(
                            value:
                                entry['atTyp1'].isEmpty
                                    ? null
                                    : entry['atTyp1'],
                            hint: Text('Type 1'),
                            isExpanded: true,
                            items:
                                attendanceTypes
                                    .map(
                                      (type) => DropdownMenuItem(
                                        value: type,
                                        child: Text(
                                          type,
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                processedData[index]['atTyp1'] = value;
                              });
                            },
                          ),
                        ),
                        // Attendance Type 2
                        Expanded(
                          child: DropdownButton<String>(
                            value:
                                entry['atTyp2'].isEmpty
                                    ? null
                                    : entry['atTyp2'],
                            hint: Text('Type 2'),
                            isExpanded: true,
                            items:
                                attendanceTypes
                                    .map(
                                      (type) => DropdownMenuItem(
                                        value: type,
                                        child: Text(
                                          type,
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                processedData[index]['atTyp2'] = value;
                              });
                            },
                          ),
                        ),
                        // Remarks
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: remarkControllers[index],
                            decoration: InputDecoration(
                              hintText: 'Add remarks',
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                            ),
                            onChanged: (value) {
                              processedData[index]['atRemark'] = value;
                            },
                          ),
                        ),
                        // Status
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(4),
                            child: _buildStatusIcon(entry['statFlag']),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: _saveAllEntries,
          child: Text('Save All Changes'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(String status) {
    IconData icon;
    Color color;
    String tooltip;

    switch (status) {
      case 'A':
        icon = Icons.pending;
        color = Colors.orange;
        tooltip = 'Pending Approval';
        break;
      case 'Y':
        icon = Icons.check_circle;
        color = Colors.green;
        tooltip = 'Approved';
        break;
      case 'N':
        icon = Icons.cancel;
        color = Colors.red;
        tooltip = 'Rejected';
        break;
      default:
        icon = Icons.help;
        color = Colors.grey;
        tooltip = 'Unknown Status';
    }

    return Tooltip(message: tooltip, child: Icon(icon, color: color));
  }

  void _saveAllEntries() async {
    try {
      // Prepare the updated data
      final updatedData =
          processedData.map((entry) {
            return {
              ...entry,
              'atRemark': remarkControllers[processedData.indexOf(entry)].text,
            };
          }).toList();

      // Here you would typically send the data to your API
      // await yourApiService.updateAttendance(updatedData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All attendance entries updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update attendance entries: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in remarkControllers) {
      controller.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }
}
