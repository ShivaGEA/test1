import 'env.dart';

class DEV extends Environment {
  @override
  String name = BuildType.DEV.toString();

  @override
  BuildType get type => BuildType.DEV;

  @override
  String baseUrl = 'https://api.github.com';

  DEV._privateConstructor();
  static final Environment _instance = DEV._privateConstructor();
  static Environment get instance => _instance;
}
