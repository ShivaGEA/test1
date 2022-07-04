import 'package:flutter/foundation.dart';

import '../../data/cache.dart';
import 'dev.dart';

enum BuildType { DEV, QA, UAT, PROD }

abstract class Environment {
  String get name;
  BuildType get type => BuildType.DEV;
  String get baseUrl;

  static const login = '/login';
  static const signup = '/signup';
  static const profile = '/profile';
  static const updateProfile = '/updateProfile';
  static const resetPassword = '/resetPassword';
  static const gitRepositories = '/repositories';
  static const gitSearch = '/search';

  static late Environment _env;
  static bool _isInitialised = false;

  static Future<Environment> get() async =>
      _isInitialised ? _env : _getEnv(await _getPreSavedEnv());

  static Future<Environment> set(BuildType buildType) async {
    await _save(buildType);
    if (buildType == BuildType.PROD) {
    } else {}
    _isInitialised = true;
    _env = _getEnv(buildType);
    return _env;
  }

  // it Load the environment from below priority order
  // Command
  // Cache
  // Default type
  static Future<Environment> load() async {
    const String type = String.fromEnvironment('Environment');
    final BuildType? buildType = _getBuildType(type);
    final preSavedEnv = await _getPreSavedEnv();
    return await Environment.set(buildType ?? preSavedEnv);
  }

  //save environment into Local database
  static Future<void> _save(BuildType type) async =>
      await (await Cache.instance).saveEnvironment(type);

  //get pre saved environment from Local database
  static Future<BuildType> _getPreSavedEnv() async =>
      //_getBuildType((await Cache.instance).environment ?? '') ??
      BuildType.DEV;

  static BuildType? _getBuildType(String type) => type != ''
      ? BuildType.values
          .firstWhere((element) => element.toString().contains(type))
      : null;

  static Environment _getEnv(BuildType buildType) {
    if (buildType == BuildType.DEV) return DEV.instance;
    return DEV.instance;
  }

  static const isDebugMode = kDebugMode;
  static const isReleaseMode = kReleaseMode;
  static const isProfileMode = kProfileMode;
}
