import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' ;

import 'package:proyecto/src/models/category.dart';
import 'package:proyecto/src/models/product.dart';
import 'package:proyecto/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:proyecto/src/providers/categories_provider.dart';
import 'package:proyecto/src/providers/products_provider.dart';

class ClientProductsListController extends GetxController{
  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();
  List<Product> selectedProducts = [];
  List<Category> categories = <Category>[].obs;
  var items = 0.obs;
  var productName = ''.obs;
  Timer? searchOnStoppedTyping;
  ClientProductsListController(){
    getCategories();

    if (GetStorage().read('shopping_bag') != null) {
      if (GetStorage().read('shopping_bag') is List<Product>) {
        selectedProducts = GetStorage().read('shopping_bag');
      }
      else {
        selectedProducts = Product.fromJsonList(GetStorage().read('shopping_bag'));
      }

      selectedProducts.forEach((p) {
        items.value = items.value + (p.quantity!);
      });

    }
  }
  void onChangeText(String text) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel();
    }

    searchOnStoppedTyping = Timer(duration, () {
      productName.value = text;
      print('TEXTO COMPLETO: ${text}');
    });
  }
  void getCategories()async{
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  Future<List<Product>> getProducts(String idCategory, String productName) async {

    if (productName.isEmpty) {
      return await productsProvider.findByCategory(idCategory);
    }
    else {
      return await productsProvider.findByNameAndCategory(idCategory, productName);
    }

  }
  void goToOrderCreate(){
    Get.toNamed('/client/orders/create');
  }
  void modalBottomSheet(BuildContext context, Product product){
    showMaterialModalBottomSheet(
      context: context,
      builder: (context)=> ClientProductsDetailPage(product:product),
    );
  }
}