import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:test1/products.dart';

import 'config/env/dev.dart';
import 'config/env/env.dart';
import 'config/routes.dart';
import 'domain/models/product.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Environment environment = DEV.instance;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'Template',
        initialRoute: Routes.productList,
        getPages: Routes.pages,
      );
}

class MyAppController extends GetxController {
  Stream? newsStream;

  @override
  void onInit() {
    super.onInit();
    debugPrint('====>init');
    _requestPermissions();
    newsStream = Stream.periodic(const Duration(seconds: 60), (_) {
      debugPrint('==> ');
      final product = Products.instance.updateRandomProductQuantity();
      _showNotificationWithNoSound(product);
    });
  }

  Future<void> _showNotificationWithNoSound(Product product) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'silent channel id', 'silent channel name',
        channelDescription: 'silent channel description',
        playSound: false,
        styleInformation: DefaultStyleInformation(true, true));
    const iOSPlatformChannelSpecifics =
        IOSNotificationDetails(presentSound: false);
    const macOSPlatformChannelSpecifics =
        MacOSNotificationDetails(presentSound: false);
    const platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: macOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0,
        '<b>${product.quantity}</b> ${product.name} available now',
        '',
        platformChannelSpecifics);
  }

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('app_icon');
  final initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (
        int id,
        String? title,
        String? body,
        String? payload,
      ) async {
        /*didReceiveLocalNotificationSubject.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );*/
      });

  void _requestPermissions() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
    });

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
}
