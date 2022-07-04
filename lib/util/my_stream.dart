import 'dart:async';

class MyStream {
  static MyStream? _instance;

  MyStream._();
  static MyStream get instance => _instance ??= MyStream._();

  StreamController<double> controller = StreamController<double>.broadcast();
  Stream get() => controller.stream;
}
