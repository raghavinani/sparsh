
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprash_arch/core/constants/theme.dart';
import 'package:sprash_arch/features/Appbar/top_appbar.dart';
import 'package:sprash_arch/features/Screens/Modal/notification_modal.dart';
import 'package:sprash_arch/features/Sidebar/View/side_bar.dart';
import 'package:sprash_arch/features/bottombar/bottombar_widget.dart';



// Updated NotificationsScreen with sample data
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  final _notificationService = NotificationService();

  Future<void> _fetchNotifications() async {
    try {
      final apiResponse = await _notificationService.fetchNotifications();
      ref.read(notificationsProvider.notifier).updateFromApi(apiResponse);
    } catch (e) {
      final sampleData = getSampleNotifications();
      ref
          .read(notificationsProvider.notifier)
          .updateFromApi(
            sampleData.map((notification) => notification.toJson()).toList(),
          );
      print('Error: $e. Using sample data.');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomSidebar(),
      bottomNavigationBar: customBottomNavigationBar(onChangePage: (int value) {  }),

      body:
          notifications.isEmpty
              ? const Center(child: Text('No notifications'))
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:
                        notifications.map((notification) {
                          final displayData = ref
                              .read(notificationsProvider.notifier)
                              .getFormattedDisplayData(notification);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Card(
                              elevation: 2,
                              child: InkWell(
                                onTap: () {
                                  if (!notification.isRead) {
                                    ref
                                        .read(notificationsProvider.notifier)
                                        .markAsRead(notification.id);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 8.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Date Container
                                      Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: AppTheme().primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              displayData['day']!,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              displayData['month']!,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              displayData['time']!,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // Message and Status
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              notification.message,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    notification.isRead
                                                        ? Colors.grey[600]
                                                        : Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              notification.status,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: _getStatusColor(
                                                  notification.status,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
