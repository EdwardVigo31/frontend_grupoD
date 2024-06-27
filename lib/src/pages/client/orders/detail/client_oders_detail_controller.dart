import 'package:get/get.dart';
import 'package:proyecto/src/models/order.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/providers/order_provider.dart';
import 'package:proyecto/src/providers/users_provider.dart';

class ClientOrdersDetailController extends GetxController {

  Order order = Order.fromJson(Get.arguments['order']);

  var total = 0.0.obs;
  var idDelivery = ''.obs;

  UserProvider usersProvider = UserProvider();
  OrderProvider ordersProvider = OrderProvider();
  List<User> users = <User>[].obs;

  ClientOrdersDetailController() {
    print('Order: ${order.toJson()}');
    getTotal();
  }

  void goToOrderMap() {
    Get.toNamed('/client/orders/map', arguments: {
      'order': order.toJson()
    });
  }

  void getTotal() {
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }

}