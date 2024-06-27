import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart'; // Import the package
import 'package:proyecto/src/pages/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:proyecto/src/pages/restaurant/home/restaurant_home_controller.dart';
import 'package:proyecto/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:proyecto/src/utils/custom_animated_botton_bar.dart'; // Ensure to import your custom widget
import '../../client/profile/info/client_profile_info_page.dart';
import '../../delivery/oders/list/delivery_orders_list_page.dart';
import '../orders/list/restaurant_orders_list_page.dart';

class RestaurantHomePage extends StatelessWidget {
  final RestaurantHomeController restaurantHomeController =
      Get.put(RestaurantHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => CurvedNavigationBar(
            // Replace CustomAnimatedBottomBar with CurvedNavigationBar
            index: restaurantHomeController.indexTab.value,
            height: 60.0,
            items: const <Widget>[
              Icon(Icons.list, size: 30, color: Colors.white),
              Icon(Icons.category, size: 30, color: Colors.white),
              Icon(Icons.restaurant, size: 30, color: Colors.white),
              Icon(Icons.person, size: 30, color: Colors.white),
            ],
            color: const Color.fromARGB(255, 0, 0, 0),
            buttonBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              restaurantHomeController.changeTab(index);
            },
            letIndexChange: (index) => true,
          )),
      body: Obx(() => IndexedStack(
            index: restaurantHomeController.indexTab.value,
            children: [
              RestaurantOrdersListPage(),
              RestaurantCategoriesCreatePage(),
              RestaurantProductsCreatePage(),
              ClientProfileInfoPage(),
            ],
          )),
    );
  }
}
