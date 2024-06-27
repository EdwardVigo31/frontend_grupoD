import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:proyecto/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:proyecto/src/pages/delivery/home/delivery_home_controller.dart';
import 'package:proyecto/src/pages/delivery/oders/list/delivery_orders_list_page.dart';
import 'package:proyecto/src/utils/custom_animated_botton_bar.dart';

class DeliveryHomePage extends StatelessWidget {
  final DeliveryHomeController deliveryHomeController =
      Get.put(DeliveryHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => CurvedNavigationBar(
            // Replace CustomAnimatedBottomBar with CurvedNavigationBar
            index: deliveryHomeController.indexTab.value,
            height: 60.0,
            items: <Widget>[
              Icon(Icons.list, size: 30, color: Colors.white),
              Icon(Icons.person, size: 30, color: Colors.white),
            ],
            color: const Color.fromARGB(255, 0, 0, 0),
            buttonBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              deliveryHomeController.changeTab(index);
            },
            letIndexChange: (index) => true,
          )),
      body: Obx(() => IndexedStack(
            index: deliveryHomeController.indexTab.value,
            children: [
              DeliveryOrdersListPage(),
              ClientProfileInfoPage(),
            ],
          )),
    );
  }
}
