import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../domain/models/product.dart';
import '../../../products.dart';
import '../../../util/my_stream.dart';
import '../../../util/notification_service.dart';

class ProductListController extends GetxController {
  var allProducts = <Product>[];
  var products = <Product>[];
  var quantityMap = <String, int>{};

  NotificationService? notificationService;

  Timer? timer;
  @override
  void onInit() {
    super.onInit();
    debugPrint('====>init:');

    notificationService = NotificationService();

    timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      final product = Products.instance.updateRandomProductQuantity();
      var map = quantityMap;
      map[product.name] = product.quantity;
      quantityMap = map;
      //debugPrint('==changed> ${product.toJson()}');
      update();
      showToast('${product.quantity} ${product.name} available now');
      notificationService?.showNotification(
        0,
        '${product.quantity} ${product.name} available now',
        '${product.quantity} ${product.name} available now',
        product.toJson().toString(),
      );
      /*notificationService?.showSimpleNotification(
          '${product.quantity} ${product.name} available now');*/
    });

    notificationService?.requestIOSPermissions();

    allProducts = Products.instance.products;
    quantityMap = mapProductQuantities(allProducts);
    products = allProducts;

    textEditingController.addListener(() {
      final text = textEditingController.text;
      onSearch(text);
    });
  }

  void onSearch(String keyword) {
    if (keyword.trim().isEmpty) {
      products = allProducts;
      debugPrint('===> $keyword : ${products.length}');

      update();
    } else {
      products = allProducts
          .where((Product product) => isValidProduct(product, keyword.trim()))
          .toList();
      debugPrint('===> $keyword : ${products.length}');

      update();
    }
  }

  final textEditingController = TextEditingController();
  final _debounce = Debounce(const Duration(milliseconds: 400));

  @override
  void dispose() {
    textEditingController.dispose();
    _debounce.dispose();
    super.dispose();
  }

  bool isValidProduct(Product product, String keyword) =>
      product.name.toLowerCase().contains(keyword.toLowerCase()) ||
      product.description.toLowerCase().contains(keyword.toLowerCase());

  Map<String, int> mapProductQuantities(List<Product> allProducts) {
    var quantityMap = <String, int>{};
    for (var product in allProducts) {
      quantityMap[product.name] = product.quantity;
    }
    return quantityMap;
  }

  final stream = MyStream.instance.get();
  StreamSubscription? subscription;

  @override
  void onClose() {
    subscription?.cancel();
    timer?.cancel();
    super.onClose();
  }

  Stream? newsStream;

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg, // message
      toastLength: Toast.LENGTH_SHORT, // length
      gravity: ToastGravity.TOP, // duration
    );
  }
  /*Future<void> _showNotificationWithNoSound(Product product) async {
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
        */ /*didReceiveLocalNotificationSubject.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );*/ /*
      });

  void _requestPermissions() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      //android: initializationSettingsAndroid,
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
  }*/
}

class Debounce {
  Duration delay;
  Timer? _timer;

  Debounce(
    this.delay,
  );

  call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  dispose() {
    _timer?.cancel();
  }
}
