import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto/src/models/category.dart';
import 'package:proyecto/src/models/product.dart';

import 'package:proyecto/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:proyecto/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:proyecto/src/pages/delivery/oders/list/delivery_orders_list_page.dart';
import 'package:proyecto/src/pages/register/register_page.dart';
import 'package:proyecto/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:proyecto/src/utils/custom_animated_botton_bar.dart';
import 'package:proyecto/src/widgets/no_data_widget.dart';

class ClientProductsListPage extends StatelessWidget {
  ClientProductsListController clientProductsController =
      Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
          length: clientProductsController.categories.length,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(130),
              child: AppBar(
                flexibleSpace: Container(
                  margin: const EdgeInsets.only(top: 15),
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [_TextFieldSearch(context), _iconShoppingBag()],
                  ),
                ),
                bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: Color.fromARGB(255, 255, 255, 255),
                  labelColor: const Color.fromARGB(255, 255, 255, 255),
                  unselectedLabelColor:
                      const Color.fromARGB(255, 255, 255, 255),
                  tabs: List<Widget>.generate(
                      clientProductsController.categories.length, (index) {
                    return Tab(
                      child: Text(
                          clientProductsController.categories[index].name ??
                              ''),
                    );
                  }),
                ),
              ),
            ),
            body: TabBarView(
              children:
                  clientProductsController.categories.map((Category category) {
                return FutureBuilder(
                    future: clientProductsController.getProducts(
                        category.id ?? '1',
                        clientProductsController.productName.value),
                    builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.length > 0) {
                          return ListView.builder(
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (_, index) {
                                return _cardProduct(
                                    context, snapshot.data![index]);
                              });
                        } else {
                          return NoDataWidget(
                            text: 'No hay productos!',
                          );
                        }
                      } else {
                        return NoDataWidget(
                          text: 'No hay productos!',
                        );
                      }
                    });
              }).toList(),
            ),
          ),
        ));
  }

  Widget _iconShoppingBag() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: clientProductsController.items.value > 0
            ? Stack(
                children: [
                  IconButton(
                      onPressed: () =>
                          clientProductsController.goToOrderCreate(),
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                        size: 33,
                      )),
                  Positioned(
                      right: 4,
                      top: 12,
                      child: Container(
                        width: 16,
                        height: 16,
                        alignment: Alignment.center,
                        child: Text(
                          '${clientProductsController.items.value}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ))
                ],
              )
            : IconButton(
                onPressed: () => clientProductsController.goToOrderCreate(),
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 30,
                  color: Colors.white,
                )),
      ),
    );
  }

  Widget _TextFieldSearch(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: TextField(
          onChanged: clientProductsController.onChangeText,
          decoration: InputDecoration(
            hintText: 'Buscar producto',
            suffixIcon: const Icon(Icons.search, color: Colors.grey),
            hintStyle: const TextStyle(fontSize: 17, color: Colors.grey),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.all(15),
          ),
          style: const TextStyle(
              color: Color.fromARGB(
                  255, 255, 0, 0)), // Aquí se establece el color negro
        ),
      ),
    );
  }

  Widget _cardProduct(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () => clientProductsController.modalBottomSheet(context, product),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(15)),
                child: FadeInImage(
                  image: product.image1 != null
                      ? NetworkImage(product.image1!)
                      : const AssetImage('assets/img/no-image.png')
                          as ImageProvider,
                  fit: BoxFit.cover,
                  height: 150,
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage('assets/img/no-image.png'),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? '',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 50, 50, 50),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'S/${product.price.toString()}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 90, 90, 90),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      product.description ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 110, 110, 110),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
