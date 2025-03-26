import 'dart:developer';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotification();
    await _scheduleNotificationsForDayWeekAndTime();
  }

  _setupTimezone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  _initializeNotification() async {
    const android = AndroidInitializationSettings(
      '@drawable/ic_notification_launcher',
    );
    const iOS = DarwinInitializationSettings();
    await localNotificationsPlugin.initialize(
      const InitializationSettings(android: android, iOS: iOS),
    );

    if (Platform.isAndroid) {
      await localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      await localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestExactAlarmsPermission();
    }
  }

  Future<void> showInstantNotification(String title, String body) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "instant_notification_channel",
        "Instant Notifications",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await localNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'instant_notification',
    );
  }

  Future<void> showDateTimeNotification(
    String title,
    String body,
    DateTime scheduledDate,
  ) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "reminder_channel",
        "Reminder Channel",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await localNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  Future<void> showDayOfWeekAndTimeNotification(
    int id,
    String title,
    String body,
    DateTime scheduledDate,
  ) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "reminder_channel",
        "Reminder Channel",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await localNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future<void> _scheduleNotificationsForDayWeekAndTime() async {
    // Lista de datas de 01/05/2000 a 05/05/2000 - Segunda a Sexta
    List<DateTime> datesToSchedule = [
      DateTime(2000, 5, 1),
      DateTime(2000, 5, 2),
      DateTime(2000, 5, 3),
      DateTime(2000, 5, 4),
      DateTime(2000, 5, 5),
    ];
    const titleLunch = "Solicite seu Almoço";
    const bodyLunch = "Abra o aplicativo e solicite seu ticket";
    const titleDinner = "Solicite seu Jantar";
    const bodyDinner = "Abra o aplicativo e solicite seu ticket";
    for (var date in datesToSchedule) {
      try {
        var scheduledLunch = DateTime(date.year, date.month, date.day, 8, 45);
        await showDayOfWeekAndTimeNotification(
          date.weekday,
          titleLunch,
          bodyLunch,
          scheduledLunch,
        );
        var scheduledDinner = DateTime(date.year, date.month, date.day, 14, 45);
        await showDayOfWeekAndTimeNotification(
          date.weekday + 6,
          titleDinner,
          bodyDinner,
          scheduledDinner,
        );
      } catch (e) {
        log("erro ao agendar notificação: ", error: e);
      }
    }
  }
}
