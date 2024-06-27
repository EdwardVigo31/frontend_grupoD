import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto/src/models/product.dart';

import '../../products/list/client_products_list_controller.dart';

class ClientOrdersCreateController extends GetxController{
  List<Product> selectProducts =<Product> [].obs;
  var total = 0.0.obs;
  ClientProductsListController productsListController = Get.find();
  ClientOrdersCreateController(){
    if(GetStorage().read('shopping_bag')!=null) {
      if (GetStorage().read('shopping_bag')is List<Product>) {
        var result =GetStorage().read('shopping_bag');
        selectProducts.clear();
        selectProducts.addAll(result);
      }
      else {
            var result =Product.fromJsonList(GetStorage().read('shopping_bag'));
            selectProducts.clear();
            selectProducts.addAll(result);
      }
      getTotal();
    }
  }
  void getTotal(){
    total.value = 0.0;
    selectProducts.forEach((product) {
      total.value = total.value+(product.quantity!*product.price!);
    });
  }
  void addItem(Product product){
    int index = selectProducts.indexWhere((p) => p.id==product.id);
    selectProducts.remove(product);
    product.quantity=product.quantity!+1;
    selectProducts.insert(index, product);
    GetStorage().write('shopping_bag', selectProducts);
    getTotal();
    productsListController.items.value = 0;
    if (selectProducts.length == 0) {
      productsListController.items.value = 0;
    }
    else {
      selectProducts.forEach((p) {
        productsListController.items.value = productsListController.items.value + p.quantity!;
      });
    }
  }
  void removeItem(Product product){
    if(product.quantity!>1){
      int index = selectProducts.indexWhere((p) => p.id==product.id);
      selectProducts.remove(product);
      product.quantity=product.quantity!-1;
      selectProducts.insert(index, product);
      GetStorage().write('shopping_bag', selectProducts);
      getTotal();
      productsListController.items.value = 0;
      if (selectProducts.length == 0) {
        productsListController.items.value = 0;
      }
      else {
        selectProducts.forEach((p) {
          productsListController.items.value = productsListController.items.value + p.quantity!;
        });
      }

    }
  }
  void deleteItem(Product product){
    selectProducts.remove(product);
    GetStorage().write('shopping_bag', selectProducts);
    getTotal();
    productsListController.items.value = 0;
    if (selectProducts.length == 0) {
      productsListController.items.value = 0;
    }
    else {
      selectProducts.forEach((p) {
        productsListController.items.value = productsListController.items.value + p.quantity!;
      });
    }
  }
  void goToAddressList(){
    Get.toNamed('/client/address/list');
  }
}