import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto/src/pages/roles/roles_controller.dart';
import 'package:proyecto/src/models/rol.dart';

class RolesPage extends StatelessWidget {
  final RolesController rolesController = Get.put(RolesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'ESCOGE EL ROL',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.17),
          child: Column(
            children: rolesController.user.roles != null &&
                    rolesController.user.roles!.isNotEmpty
                ? rolesController.user.roles!.map((Rol rol) {
                    return _cardRol(rol);
                  }).toList()
                : [const Center(child: Text('No roles available'))],
          ),
        ),
      ),
    );
  }

  Widget _cardRol(Rol rol) {
    return GestureDetector(
      onTap: () => rolesController.goToPageRol(rol),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  rol.image!,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10), // Margin between image and text
              Text(
                rol.name ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
