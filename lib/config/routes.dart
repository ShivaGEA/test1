import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:test1/ui/pages/products/product_list_page.dart';

class Routes {
  static const productList = '/product-list';
  static const productPage = '/product-page';

  static List<GetPage> get pages => [
        GetPage(
          name: productList,
          page: () => ProductListPage(),
        ),
      ];
}
