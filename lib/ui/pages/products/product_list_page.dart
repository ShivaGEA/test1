import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:test1/ui/widgets/ProductWidget.dart';

import 'product_list_controller.dart';

class ProductListPage extends GetView<ProductListController> {
  @override
  final controller = Get.put(ProductListController());

  ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          color: Colors.white,
          child: Center(
            child: TextField(
              controller: controller.textEditingController,
              onChanged: (String keyword) => controller.onSearch(keyword),
              decoration: decoration,
            ),
          ),
        ),
      ),
      body: GetBuilder(
          init: Get.put(ProductListController()),
          builder: (GetxController controller) => _body()),
      //body: Container(),
    );
  }

  final decoration = const InputDecoration(
    hintText: 'Search',
    contentPadding: EdgeInsets.all(10.0),
    prefixIcon: Icon(Icons.search),
    suffixIcon: Icon(Icons.camera_alt),
  );

  Widget _body() => Container(
        child: controller.products.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.products.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return ProductWidget(
                    product.name,
                    product.description,
                    controller.quantityMap[product.name] ?? 0,
                    key: Key(product.name),
                  );
                },
              )
            : const Center(child: Text('No items found')),
      );
}
