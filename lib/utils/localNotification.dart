import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin _notifyPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initialSettings = InitializationSettings(
        android: AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    ));
    _notifyPlugin.initialize(initialSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) {
      print('onDidReceiveNotificationResponse Function');
      print(details.payload.toString());
      print(details.payload != null);
    });
  }

  static void showNotification(RemoteMessage message) {
    final NotificationDetails notifyDetails = NotificationDetails(
      android: AndroidNotificationDetails(
          'com.example.graphiceranotification', 'Graphic',
          importance: Importance.max, priority: Priority.max),
    );
    _notifyPlugin.show(DateTime.now().microsecond, message.notification!.title,
        message.notification!.body, notifyDetails,
        payload: message.data.toString());
  }
}
