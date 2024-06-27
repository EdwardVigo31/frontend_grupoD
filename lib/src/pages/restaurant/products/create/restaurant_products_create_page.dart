import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto/src/models/category.dart';
import 'package:proyecto/src/pages/restaurant/products/create/restaurant_products_create_controller.dart';

class RestaurantProductsCreatePage extends StatelessWidget {
  RestaurantProductsCreateController con =
      Get.put(RestaurantProductsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(context),
          _buildSquareBox(context),
          _textNewCategory(context),
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.20,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(50),
        ),
      ),
    );
  }

  Widget _textNewCategory(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        alignment: Alignment.topCenter,
        child: const Text(
          'NUEVO PRODUCTO',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 23, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSquareBox(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.55,
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.27,
            left: 20,
            right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _textFieldName(),
                _textFieldDescription(),
                _textFieldPrice(),
                _dropDownCategories(con.categories),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetBuilder<RestaurantProductsCreateController>(
                        builder: (value) =>
                            _cardImage(context, con.imageFile1, 1)),
                    GetBuilder<RestaurantProductsCreateController>(
                        builder: (value) =>
                            _cardImage(context, con.imageFile2, 2)),
                    GetBuilder<RestaurantProductsCreateController>(
                        builder: (value) =>
                            _cardImage(context, con.imageFile3, 3)),
                  ],
                ),
                _buttonCreate(context),
              ],
            ),
          ),
        ));
  }

  Widget _textFieldName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: con.nameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          hintText: 'Nombre',
          prefixIcon: Icon(Icons.category),
        ),
      ),
    );
  }

  Widget _textFieldDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: TextField(
        controller: con.descriptionController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          hintText: 'Descripción',
          prefixIcon: Padding(
            padding: EdgeInsetsDirectional.only(start: 12.0, bottom: 8.0),
            child: Icon(Icons.description),
          ),
        ),
      ),
    );
  }

  Widget _textFieldPrice() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: con.priceController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: 'Precio',
          prefixIcon: Icon(Icons.attach_money),
        ),
      ),
    );
  }

  Widget _dropDownCategories(List<Category> categories) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      margin: const EdgeInsets.only(top: 15),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.red,
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: const Text(
          'Seleccionar categoría',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        items: _dropDownItems(categories),
        value: con.idCategory.value == '' ? null : con.idCategory.value,
        onChanged: (option) {
          print('Opción seleccionada ${option}');
          con.idCategory.value = option.toString();
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Category> categories) {
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
        child: Text(category.name ?? ''),
        value: category.id,
      ));
    });

    return list;
  }

  Widget _cardImage(BuildContext context, File? imageFile, int numberFile) {
    return GestureDetector(
      onTap: () => con.showAlertDialog(context, numberFile),
      child: Card(
        elevation: 3,
        child: Container(
          padding: const EdgeInsets.all(1),
          height: 75,
          width: MediaQuery.of(context).size.width * 0.20,
          child: imageFile != null
              ? Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                )
              : const Image(
                  image: AssetImage('assets/img/comida.png'),
                ),
        ),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
      child: ElevatedButton(
        onPressed: () {
          con.createProduct(context);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          primary: const Color.fromARGB(
              255, 255, 17, 0), // Aquí estableces el color de fondo del botón
        ),
        child: const Text(
          'CREAR PRODUCTO',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
