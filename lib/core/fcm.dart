import 'dart:convert';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final _fcm = FirebaseMessaging.instance;
  String? fCMToken;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: "This channel is used for important notifications",
    importance: Importance.defaultImportance,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    // navigatorKey.currentState?.push(
    //   PageTransition(
    //     child: NotificationsScreen(),
    //     type: PageTransitionType.fade,
    //   ),
    // );
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/launcher_icon');
    const iOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        // Handle notification tap
        handleMessage(null);
      },
    );
  }

  Future initPushNotifications() async {
    await _fcm.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
    FirebaseMessaging.instance.getInitialMessage().then(
      (value) => handleMessage(value),
    );
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@mipmap/launcher_icon',
          ),
        ),
        payload: jsonEncode(event.toMap()),
      );
    });
    //  print("Token: $fCMToken");
  }

  Future<void> initialize() async {
    try {
      if (Platform.isIOS) {
        // Request permission first with all options
        // ignore: unused_local_variable
        final settings = await _fcm.requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );

        // Configure foreground notification presentation options
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
              alert: true,
              badge: true,
              sound: true,
            );

        // Initialize local notifications
        await initLocalNotifications();

        // Now try to get the actual APNS token
        String? apnsToken;
        int retries = 0;
        while (apnsToken == null && retries < 5) {
          apnsToken = await _fcm.getAPNSToken();
          if (apnsToken != null) {
            break;
          }
          await Future.delayed(const Duration(seconds: 2));
          retries++;
        }

        if (apnsToken == null) {
          throw Exception(
            'Failed to get APNS token - check Xcode configuration',
          );
        }
      } else {
        // For non-iOS platforms, just initialize normally
        await initLocalNotifications();
        await _fcm.requestPermission();
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
              alert: true,
              badge: true,
              sound: true,
            );
      }

      // Get FCM token after APNS is ready
      fCMToken = await _fcm.getToken();
      if (fCMToken != null) {
        await CacheHelper.saveData(key: CacheKeys.fcmToken, value: fCMToken);
      }

      // Initialize push notifications last
      await initPushNotifications();
    } catch (e) {
      // Re-throw the error to let the caller handle it
      rethrow;
    }
  }
}
