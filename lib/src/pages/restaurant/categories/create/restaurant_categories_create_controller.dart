import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:proyecto/src/providers/categories_provider.dart';

import '../../../../models/category.dart';
import '../../../../models/response_api.dart';

class RestaurantCategoriesCreateController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  CategoriesProvider categoriesProvider =  CategoriesProvider();

  void createCategory()async{
    String name =  nameController.text;
    String description = descriptionController.text;

    if(name.isNotEmpty && description.isNotEmpty){
      Category category =  Category(
        name: name,
        description: description
      );

      ResponseApi responseApi = await categoriesProvider.create(category);
      Get.snackbar('Proceso terminado', responseApi.message?? '');
      if(responseApi.success ==true){
        clearForm();
      }
    }
    else{
      Get.snackbar('Formulario no valido', 'ingresa todos los campos para crear la categoria');
    }
  }
  void clearForm(){
    nameController.text = '';
    descriptionController.text= '';
  }

}