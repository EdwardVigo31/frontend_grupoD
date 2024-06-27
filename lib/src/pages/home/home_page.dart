import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto/src/pages/home/home_controller.dart';


class HomePage extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed:() => homeController.signOut() ,
          child: Text(
              'Cerrar Sesión',
            style: TextStyle(
              color: Colors.black
            ),
          ),
        ),
      ),
    );
  }
}
