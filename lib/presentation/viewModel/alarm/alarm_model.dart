import 'dart:developer';

import 'package:container_tracking/core/helpers/view_functions.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../core/utils/constants.dart';

class NotificationService {
  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    //Initialization Settings for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    //Initialization Settings for iOS
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification:
                (int id, String? title, String? body, String? payload) async {
              log('>>>>>>>>>>>>>>>>>>>>>onDidReceiveLocalNotification<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
            });

    //Initializing settings for both platforms (Android & iOS)
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  onSelectNotification(String? payload) async {
    //Navigate to wherever you want
  }

  requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> showNotifications({id, title, body, payload}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<void> scheduleNotifications(
      {context,
      id,
      companyName,
      portAccess,
      containerNumber,
      required DateTime time,
      desc}) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
      ),
    );
    try {
      ///set alarm before 10 days from date
      if (time.subtract(const Duration(days: 10)).isAfter(DateTime.now())) {
        await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          " بعد 10 ايام لديك شحنة فى ميناء $portAccess",
          "$companyName  /  $containerNumber",
          tz.TZDateTime.from(time.subtract(const Duration(days: 10)), tz.local),
          notificationDetails,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      }
      if (time.subtract(const Duration(days: 5)).isAfter(DateTime.now())) {
        await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          " بعد 5 ايام لديك شحنة فى ميناء $portAccess",
          "$companyName  /  $containerNumber",
          tz.TZDateTime.from(time.subtract(const Duration(days: 5)), tz.local),
          notificationDetails,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      }
      if (time.subtract(const Duration(days: 3)).isAfter(DateTime.now())) {
        await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          " بعد 3 ايام لديك شحنة فى ميناء $portAccess",
          "$companyName  /  $containerNumber",
          tz.TZDateTime.from(time.subtract(const Duration(days: 3)), tz.local),
          notificationDetails,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      }
      await flutterLocalNotificationsPlugin
          .zonedSchedule(
              id,
              " اليوم لديك شحنة فى ميناء $portAccess",
              "$companyName  /  $containerNumber",
              tz.TZDateTime.from(time, tz.local),
              notificationDetails,
              androidAllowWhileIdle: true,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime)
          .then((value) async {
        var prefs = await SharedPreferences.getInstance();
        await prefs.setString(Constants.alarmDate, time.toString());
        await prefs.setString(Constants.portAccess, portAccess);
        await prefs.setString(Constants.companyName, companyName);
        await prefs.setString(Constants.containerNumber, containerNumber);
        await prefs.setString(Constants.alarmDescription, desc ?? '');

        ViewFunctions.showCustomSnackBar(
          context: context,
          text: 'تم اضافة تذكير بوصول الشحنة',
        );
      });
    } catch (e) {
      ViewFunctions.showCustomSnackBar(
        context: context,
        text: 'خطأ اثناء اضافة تذكير بوصول الشحنة',
      );
    }
  }
}
