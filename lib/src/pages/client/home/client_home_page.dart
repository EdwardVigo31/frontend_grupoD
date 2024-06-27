import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:proyecto/src/pages/client/orders/list/client_orders_list_page.dart';
import 'package:proyecto/src/pages/client/products/list/client_products_list_page.dart';
import 'package:proyecto/src/pages/client/profile/info/client_profile_info_page.dart';

import 'client_home_controller.dart';

class ClientHomePage extends StatelessWidget {
  final ClientHomeController clientHomeController =
      Get.put(ClientHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => CurvedNavigationBar(
            index: clientHomeController.indexTab.value,
            height: 60.0,
            items: const <Widget>[
              Icon(Icons.home, size: 30, color: Colors.white),
              Icon(Icons.shopping_bag, size: 30, color: Colors.white),
              Icon(Icons.person, size: 30, color: Colors.white),
            ],
            color: Colors.black,
            buttonBackgroundColor: Colors.black,
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              clientHomeController.changeTab(index);
            },
            letIndexChange: (index) => true,
          )),
      body: Obx(() => IndexedStack(
            index: clientHomeController.indexTab.value,
            children: [
              ClientProductsListPage(),
              ClientOrdersListPage(),
              ClientProfileInfoPage()
            ],
          )),
    );
  }
}

class ClientHomeController extends GetxController {
  var indexTab = 0.obs;

  void changeTab(int index) {
    indexTab.value = index;
  }
}
