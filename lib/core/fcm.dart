import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_project/core/services/shared_pref_services.dart';

// top level function — must be outside the class
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background message: ${message.messageId}');
}

class PushNotificationService {
  final _fcm = FirebaseMessaging.instance;
  String? fcmToken;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.high,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
  }

  Future<void> initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);
    const settings = InitializationSettings(android: android, iOS: ios);
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        handleMessage(null);
      },
    );

    // create android notification channel
    await _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(_androidChannel);
  }

  Future<void> initPushNotifications() async {
    await _fcm.requestPermission(alert: true, announcement: true, badge: true, carPlay: false, criticalAlert: false, provisional: true, sound: true);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
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
            icon: '@mipmap/ic_launcher',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        payload: jsonEncode(event.toMap()),
      );
    });
  }

  Future<void> initialize() async {
    try {
      if (Platform.isIOS) {
        await _fcm.requestPermission(alert: true, announcement: true, badge: true, carPlay: false, criticalAlert: false, provisional: false, sound: true);
        await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
        await initLocalNotifications();
        String? apnsToken;
        int retries = 0;
        while (apnsToken == null && retries < 5) {
          apnsToken = await _fcm.getAPNSToken();
          if (apnsToken != null) break;
          await Future.delayed(const Duration(seconds: 2));
          retries++;
        }
        if (apnsToken == null) {
          throw Exception('Failed to get APNS token');
        }
      } else {
        await initLocalNotifications();
        await _fcm.requestPermission();
        await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      }

      // get and save FCM token
      fcmToken = await _fcm.getToken();
      if (fcmToken != null) {
        await SharedPrefService.setString('fcmToken', fcmToken!);
        print('✅ FCM Token: $fcmToken');
      }

      await initPushNotifications();
    } catch (e) {
      print('❌ PushNotificationService error: $e');
      rethrow;
    }
  }

  // show local notification on payment success
  Future<void> showPaymentSuccessNotification() async {
    await _localNotifications.show(
      0,
      '🎉 Order Placed!',
      'Your order has been placed successfully.',
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          icon: '@mipmap/ic_launcher',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }
}
