import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseAppConfig {
  static FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  static Future<void> initialize() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    await remoteConfig.setDefaults(const {
      'login_showfacebookicon': false,
    });
  }

  static Future<void> getMap() async {
    await remoteConfig.fetchAndActivate();
  }
}
