import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';

class RestaurantCategoriesCreatePage extends StatelessWidget {
  RestaurantCategoriesCreateController restaurantCategoriesCreateController =
      Get.put(RestaurantCategoriesCreateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _backgroundMainImage(context),
        _squareBox(context),
        _textNewCategory(context),
      ],
    ));
  }

  Widget _backgroundMainImage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.20,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(
              50), // Ajusta el valor para controlar la curvatura
        ),
      ),
      alignment: Alignment.topCenter,
    );
  }

  Widget _textNewCategory(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.only(top: 50),
          alignment: Alignment.topCenter,
          child: const Column(
            children: [
              Text(
                'CREAR NUEVA CATEGORIA',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 25),
              ),
            ],
          )),
    );
  }

  Widget _squareBox(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.46,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.30,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
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
              _buttonCreate(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: restaurantCategoriesCreateController.nameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          hintText: 'Nombre',
          prefixIcon: Padding(
            padding: EdgeInsetsDirectional.only(start: 12.0),
            child: Icon(Icons.food_bank),
          ),
        ),
      ),
    );
  }

  Widget _textFieldDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: TextField(
        controller: restaurantCategoriesCreateController.descriptionController,
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

  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: ElevatedButton(
          onPressed: () =>
              restaurantCategoriesCreateController.createCategory(),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            primary: const Color.fromARGB(255, 255, 17, 0),
          ),
          child: const Text(
            'CREAR CATEGORIA',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          )),
    );
  }
}
