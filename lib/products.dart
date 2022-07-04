import 'dart:async';
import 'dart:math';

import 'domain/models/product.dart';

class Products {
  static Products? _instance;
  var products = <Product>[];

  final streamController = StreamController<Product>.broadcast();
  Stream<Product> getProductUpdateStream() => streamController.stream;

  Products._() {
    _loadProductsFromJson();
  }
  static Products get instance => _instance ??= Products._();

  void _loadProductsFromJson() {
    products = ProductList.fromJson(mockData).products ?? [];
  }

  void updateProductQuantity(Product product, int quantity) {
    for (var productItem in products) {
      if (productItem.name == product.name) {
        productItem.quantity = quantity;
        break;
      }
    }
  }

  // product related operation by external call
  final _random = Random();
  Product pickRandomProductFromList() =>
      products[_random.nextInt(products.length)];

  Product reduceProductQuantityByOne(Product randomProduct) {
    //debugPrint('Random Prod:  ${randomProduct.toJson()}');
    if (randomProduct.quantity > 0) {
      randomProduct.quantity = randomProduct.quantity - 1;
      updateProductQuantity(randomProduct, randomProduct.quantity);
      streamController.add(randomProduct);
    }
    return randomProduct;
  }

  Product updateRandomProductQuantity() =>
      reduceProductQuantityByOne(pickRandomProductFromList());

  Map<String, dynamic> mockData = {
    "products": [
      {
        "name": "mango",
        "description": "this is seasonal fruit",
        "quantity": "200"
      },
      {"name": "watermelon", "description": "this is fruit", "quantity": "20"},
      {"name": "grapes", "description": "this is fruit", "quantity": "200"},
      {"name": "pizza", "description": "this is junk food", "quantity": "1"},
      {"name": "donut", "description": "this is junk food", "quantity": "11"},
      {"name": "papaya", "description": "this is fruit", "quantity": "2"},
      {"name": "blue-berry", "description": "this is fruit", "quantity": "0"},
      {"name": "strawberry", "description": "this is fruit", "quantity": "209"},
      {
        "name": "cucumber",
        "description": "this is cucumber healthy",
        "quantity": "10"
      },
      {"name": "potato", "description": "this is vegetable", "quantity": "25"},
      {"name": "beans", "description": "this is vegetable", "quantity": "266"},
      {"name": "garlic", "description": "this is garlic m", "quantity": "5"},
      {"name": "pumpkin", "description": "this is vegetable", "quantity": "1"},
      {"name": "mint", "description": "this is mint fl", "quantity": "211"},
      {"name": "spinach", "description": "this is good", "quantity": "2"},
      {"name": "corn", "description": "this is super taste", "quantity": "29"},
      {
        "name": "cauliflower",
        "description": "this is vegetable",
        "quantity": "20"
      },
      {"name": "mirchi", "description": "this is vegetable", "quantity": "24"},
      {
        "name": "sweet potato",
        "description": "this is sweet",
        "quantity": "23"
      },
      {"name": "salad", "description": "Good in taste", "quantity": "11"}
    ]
  };
}
