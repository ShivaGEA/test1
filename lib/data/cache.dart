import 'dart:async';

import '/config/env/env.dart';

class _Key {
  static const String environment = 'environment';
  static const String theme = 'theme';
  static const String locale = 'locale';
}

class Cache {
  //SharedPreferences? _prefs;
  static Cache? _instance;
  static Future<Cache> get instance async => _instance ?? await getInstance();

  static Future<Cache> getInstance() async {
    _instance = Cache._();
    //await _instance!._init();
    return _instance!;
  }

  Cache._();

  Future<void> saveEnvironment(BuildType type) async {
    return;
  }
}
