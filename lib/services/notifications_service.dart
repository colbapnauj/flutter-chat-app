// D7:34:F5:7F:2A:97:56:6A:7A:A8:4A:1C:22:FA:51:C6:33:54:34:C0

import 'dart:async';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static String? token;
  static final StreamController<String> _messageStream =
      StreamController.broadcast();

  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    _messageStream.add(message.data['product'] ?? 'No body');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _onMessaageOpenApp(RemoteMessage message) async {
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future initializeApp() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;

    token = await FirebaseMessaging.instance.getToken(
        vapidKey:
            'BIL6ulEbSh8gtcA_k4HQeyJMwtHGrJYZZYKBGAnAHNLivZtcY-IIFjKgnsawN2P0pyie6nxxXfu3LAN66yrkiTo');

    /// Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessaageOpenApp);
    // TODO Grabar token en el backend

    // TODO Implementar Local notifications
  }

  static closeStreams() {
    _messageStream.close();
  }

  Future<void> updateFCMToken(String token) async {}
}
