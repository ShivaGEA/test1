import 'data/cache.dart';

Future<void> setupLocator() async {
  await _loadCache();
  await _setupResources();
}

Future<void> _loadCache() async {
  final instance = await Cache.instance; //loadcache
  //debugPrint('==> Cache Env==> ${instance.environment}');
}

Future<void> _setupResources() async {
  gitResourcesInit();
}

//resources initialising
void gitResourcesInit() {}
