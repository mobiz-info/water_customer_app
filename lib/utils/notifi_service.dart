
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:water_customer_app/Models/notification_model.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;


class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/launcher_icon');
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,

      // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS,
    );
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});

    // Create a notification channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // ID
      'High Importance Notifications', // Name
      description: 'This channel is used for important notifications.', // Description
      importance: Importance.high,
    );

    // Register the channel with the system
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
    // Handle the notification received event

  print('@@@@@@@@@@@@@@@@@@@@');
  print(title);
  print(body);
  }
  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel', 'channelN',
            importance: Importance.max));
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {

    globals.expenseAddList?.insert(0,Data(time: DateFormat('yyyy-MM-dd HH:mm: a').format(DateTime.now()),title: title,messaage: body));
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
}