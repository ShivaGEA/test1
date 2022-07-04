import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductWidget extends GetView<ProductWidgetController> {
  final String name;
  ProductWidget(this.name, String description, int quantity, {Key? key})
      : super(key: key) {
    controller.name.value = name;
    controller.description.value = description;
    controller.quantity.value = quantity;
  }

  @override
  ProductWidgetController get controller =>
      Get.put(ProductWidgetController(), tag: name);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          color: Colors.black12,
          child: Obx(
            () => Text(
                'Title: ${controller.name} \nDescription: ${controller.description} \nQuantity: ${controller.quantity}'),
          ),
        ),
      );
}

class ProductWidgetController extends GetxController {
  final name = ''.obs;
  final description = ''.obs;
  final quantity = 0.obs;
}
