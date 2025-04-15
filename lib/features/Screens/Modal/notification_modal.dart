import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

List<NotificationItem> getSampleNotifications() {
  return [
    NotificationItem(
      id: '1',
      message: 'Your order #12345 has been confirmed and is being processed.',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      status: 'Completed',
      type: 'order',
      isRead: false,
    ),
    NotificationItem(
      id: '2', 
      message: 'Payment of ₹1,500 has been processed successfully.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      status: 'Completed',
      type: 'payment',
      isRead: true,
    ),
    NotificationItem(
      id: '3',
      message: 'Special 20% discount on all electronics. Limited time offer!',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      status: 'Cancelled',
      type: 'promotion',
      isRead: false,
    ),
    NotificationItem(
      id: '4',
      message: 'Your package is out for delivery.',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      status: 'In Progress',
      type: 'delivery',
      isRead: false,
    ),
    NotificationItem(
      id: '5',
      message: 'Your profile has been successfully updated.',
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      status: 'In Progress',
      type: 'account',
      isRead: true,
    ),
  ];
}
class NotificationItem {
  final String id;
  final String message;
  final DateTime timestamp;
  final String status;
  final String type;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.message,
    required this.timestamp,
    required this.status,
    required this.type,
    this.isRead = false,
  });

  // Convert NotificationItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
      'type': type,
      'isRead': isRead,
    };
  }

  // Create NotificationItem from API response
  factory NotificationItem.fromApiResponse(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      timestamp: json['timestamp'] != null 
          ? DateTime.parse(json['timestamp'].toString())
          : DateTime.now(),
      status: json['status']?.toString() ?? 'pending',
      type: json['type']?.toString() ?? 'general',
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  NotificationItem copyWith({
    String? id,
    String? message,
    DateTime? timestamp,
    String? status,
    String? type,
    bool? isRead,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  String toString() {
    return 'NotificationItem(id: $id, message: $message, timestamp: $timestamp, status: $status, type: $type, isRead: $isRead)';
  }

  
}


final notificationsProvider = StateNotifierProvider<NotificationsNotifier, List<NotificationItem>>((ref) {
  return NotificationsNotifier();
});

class NotificationsNotifier extends StateNotifier<List<NotificationItem>> {
  NotificationsNotifier() : super([]);
  final _notificationService = NotificationService();

  // Update notifications from API response
  void updateFromApi(List<Map<String, dynamic>> apiResponse) {
    try {
      final validItems = apiResponse.where((item) => item != null).toList();
      state = validItems.map((item) => NotificationItem.fromApiResponse(item)).toList();
    } catch (e) {
      print('Error updating notifications: $e');
      state = [];
    }
  }

  // Add a new notification
  void addNotification(NotificationItem notification) {
    state = [...state, notification];
  }

  // Mark notification as read
  void markAsRead(String id) {
    state = state.map((notification) {
      if (notification.id == id) {
        return notification.copyWith(isRead: true);
      }
      return notification;
    }).toList();
  }

  // Remove a notification
  void removeNotification(String id) {
    state = state.where((notification) => notification.id != id).toList();
  }

  // Format date components
  String getFormattedDay(DateTime date) => date.day.toString().padLeft(2, '0');
  
  String getFormattedMonth(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[date.month - 1];
  }
  
  String getFormattedYear(DateTime date) => date.year.toString();
  
  String getFormattedTime(DateTime date) {
    final hour = date.hour > 12 ? date.hour - 12 : date.hour;
    final amPm = date.hour >= 12 ? 'pm' : 'am';
    return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}$amPm';
  }

  // Load notifications from JSON string
  void loadFromJson(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    state = jsonList.map((json) => NotificationItem.fromApiResponse(json)).toList();
  }

  // Convert notifications to JSON string
  String toJsonString() {
    return json.encode(state.map((notification) => notification.toJson()).toList());
  }

  // Get formatted display data for a notification
  Map<String, String> getFormattedDisplayData(NotificationItem notification) {
    return {
      'day': getFormattedDay(notification.timestamp),
      'month': getFormattedMonth(notification.timestamp),
      'year': getFormattedYear(notification.timestamp),
      'time': getFormattedTime(notification.timestamp),
    };
  }
 
}

// Example API service class
class NotificationService {
  Future<List<Map<String, dynamic>>> fetchNotifications() async {
    try {
      // Replace with your actual API endpoint
      final response = await http.get(
        Uri.parse('your-api-endpoint/notifications'),
        headers: {
          'Content-Type': 'application/json',
          // Add any required headers (e.g., authorization)
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load notifications: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching notifications: $e');
    }
  }
}


