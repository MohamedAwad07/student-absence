import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permission
    await _requestPermission();

    // Setup message handlers
    await _setupMessageHandlers();

    // Get FCM token with error handling
    try {
      final token = await _messaging.getToken();
      log('FCM Token: ${token ?? 'null'}');
      // Send this token to your backend if you want to target this device for notifications.
    } catch (e) {
      // Log error for debugging (use a logging framework in production)
      // Example: logger.e('Error retrieving FCM token', e, stack);
    }
  }

  /// Public getter for FCM token with error handling
  Future<String?> getFcmToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      // Log error for debugging (use a logging framework in production)
      // Example: logger.e('Error retrieving FCM token', e, stack);
      log("Error retrieving FCM token: $e");
      return null;
    }
  }

  /// Stream for FCM token refresh events
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  Future<void> _requestPermission() async {
    // ignore: unused_local_variable
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }
    try {
      // android setup
      const channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);

      const initializationSettingsAndroid = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );

      const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
      );

      // flutter notification setup
      await _localNotifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) {},
      );

      _isFlutterLocalNotificationsInitialized = true;
    } catch (e) {
      // Log error for debugging (use a logging framework in production)
      // Example: logger.e('Error setting up local notifications', e, stack);
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    try {
      final RemoteNotification? notification = message.notification;
      final AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        await _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              channelDescription:
                  'This channel is used for important notifications.',
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: message.data.toString(),
        );
      }
    } catch (e) {
      // Log error for debugging (use a logging framework in production)
      // Example: logger.e('Error showing notification', e, stack);
    }
  }

  Future<void> _setupMessageHandlers() async {
    //foreground message
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });

    // background message
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // opened app
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    try {
      if (message.data['type'] == 'chat') {
        //Implement navigation to chat screen or handle chat notification tap
        // Example: Navigator.of(context).pushNamed('/chat', arguments: ...);
      }
      // Add more types as needed
    } catch (e, stack) {
      // Log error for debugging (use a logging framework in production)
      // Example: logger.e('Error handling background message', e, stack);
      log("Error handling background message: $e\n$stack");
      // If you want to use a logging framework, ensure logger.e is a function, not a variable.
      // If logger.e is not a function, replace with print or another logging method:
      // print('Error handling background message: $e\n$stack');
      // Or, if using a logging package, ensure correct usage.
      // For example, if using the 'logging' package:
      // log('Error handling background message', error: e, stackTrace: stack);
      // Remove or update the above line as appropriate for your logger.
    }
  }
}
