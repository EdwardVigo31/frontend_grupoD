import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto/src/models/product.dart';
import 'package:proyecto/src/pages/client/products/list/client_products_list_controller.dart';

class ClientProductsDetailController extends GetxController{
  List<Product> selectProducts=[];
  ClientProductsListController productsListController = Get.find();


  void checkIfProductsWasAdded(Product product, var price, var counter ){
    price.value = product.price??0.0;

    if(GetStorage().read('shopping_bag')!=null){

      if(GetStorage().read('shopping_bag')is List<Product>){
        selectProducts=GetStorage().read('shopping_bag');
      }
      else{
        selectProducts=Product.fromJsonList(GetStorage().read('shopping_bag'));
      }
      int index = selectProducts.indexWhere((p) => p.id==product.id);

      if(index!=-1){
        counter.value=selectProducts[index].quantity??0;
        price.value=product.price!*counter.value;
        selectProducts.forEach((p) {
          print('El producto: ${p.toJson()}');
        });
      }


    }

  }
  void addToBag(Product product, var price, var counter){
    if(counter.value>0){
      int index = selectProducts.indexWhere((p) => p.id==product.id);
      if(index==-1){
        if(product.quantity==null){
          if(counter.value>0){
            product.quantity=counter.value;
          }else{
            product.quantity=1;
          }

        }
        selectProducts.add(product);
      }
      else{
        selectProducts[index].quantity=counter.value;
      }
      GetStorage().write('shopping_bag', selectProducts);
      Fluttertoast.showToast(msg: 'Producto agregado');
      productsListController.items.value = 0;
      selectProducts.forEach((p) {
        productsListController.items.value = productsListController.items.value + p.quantity!;
      });
    }
    else{
      Fluttertoast.showToast(msg: 'Debes seleccionar al menos un item para agregar');
    }

  }


  void addItem(Product product, var price, var counter){
    counter.value=counter.value+1;
    price.value=product.price!*counter.value;
  }
  void removeItem(Product product, var price, var counter){
    if(counter.value>0){
      counter.value=counter.value-1;
      price.value=product.price!*counter.value;
    }
  }
}