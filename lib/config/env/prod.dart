import 'env.dart';

class PROD extends Environment {
  @override
  String name = BuildType.PROD.toString();

  @override
  BuildType get type => BuildType.PROD;

  @override
  String baseUrl = 'https://api.github.com';

  PROD._privateConstructor();
  static final Environment _instance = PROD._privateConstructor();
  static Environment get instance => _instance;
}
