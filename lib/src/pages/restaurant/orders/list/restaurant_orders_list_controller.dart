import 'package:get/get.dart';
import 'package:proyecto/src/models/order.dart';
import 'package:proyecto/src/providers/order_provider.dart';

class RestaurantOrdersListController extends GetxController {
  OrderProvider ordersProvider = OrderProvider();
  List<String> status =
      <String>['PAGADO', 'DISTRIBUIDO', 'EN CAMINO', 'ENTREGADO'].obs;

  Future<List<Order>> getOrders(String status) async {
    return await ordersProvider.findByStatus(status);
  }

  void goToOrderDetail(Order order) {
    Get.toNamed('/restaurant/orders/detail',
        arguments: {'order': order.toJson()});
  }
}
