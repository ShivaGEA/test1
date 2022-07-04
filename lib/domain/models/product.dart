import 'package:flutter/material.dart';

class Product {
  String name = '';
  String description = '';
  var quantity = 0;

  Product({this.name = '', this.description = '', this.quantity = 0});

  Product.fromJson(dynamic json) {
    debugPrint('==> $json');
    name = json['name'];
    description = json['description'];
    quantity = int.parse(json['quantity']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['description'] = description;
    map['quantity'] = quantity;
    return map;
  }
}

class ProductList {
  List<Product>? products;

  ProductList({this.products});

  ProductList.fromJson(dynamic json) {
    final productListJson = json['products'];
    if (productListJson is List) {
      products = productListJson.toList().map((productJson) {
        return Product.fromJson(productJson);
      }).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    var data = products?.map((product) => product.toJson()).toList();
    map['products'] = data;
    return map;
  }
}
