import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'register_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _blackBackground(),
        _backgroundMainImage(context),
        _squareBox(context),
        _imageUser(context),
        _buttonBack()
      ],
    ));
  }

  Widget _blackBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
    );
  }

  Widget _squareBox(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.30, left: 20, right: 20),
      decoration: const BoxDecoration(
          color: Color.fromARGB(0, 185, 185, 185),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color.fromARGB(136, 0, 0, 0),
                blurRadius: 15,
                offset: Offset(0, 0.75))
          ]),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textFieldEmail(),
            const SizedBox(height: 10),
            _textFieldName(),
            const SizedBox(height: 10),
            _textFieldLastName(),
            const SizedBox(height: 10),
            _textFieldPhone(),
            const SizedBox(height: 10),
            _textFielPassword(),
            const SizedBox(height: 10),
            _textFielConfirmPassword(),
            _buttonRegister(context)
          ],
        ),
      ),
    );
  }

  Widget _buttonRegister(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: ElevatedButton(
        onPressed: () => registerController.register(context),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Aquí defines el color rojo del botón
            padding: const EdgeInsets.symmetric(vertical: 18)),
        child: const Text(
          'REGISTRARSE',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }

  Widget _textFielPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: registerController.passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Contraseña',
          hintStyle: TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
          prefixIcon: Icon(Icons.lock, color: Colors.white),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _textFielConfirmPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: registerController.confirmPasswordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Confirmar Contraseña',
          hintStyle: TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
          prefixIcon: Icon(Icons.lock_clock_outlined, color: Colors.white),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: registerController.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: 'Correo electronico',
          hintStyle: TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
          prefixIcon: Icon(Icons.email, color: Colors.white),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: registerController.nameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          hintText: 'Nombre',
          hintStyle: TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
          prefixIcon: Icon(Icons.person, color: Colors.white),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: registerController.lastnameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          hintText: 'Apellido',
          hintStyle: TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
          prefixIcon: Icon(Icons.person_2_outlined, color: Colors.white),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: registerController.phoneController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          hintText: 'celular',
          hintStyle: TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
          prefixIcon: Icon(Icons.phone_android, color: Colors.white),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _backgroundMainImage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.38,
      color: const Color.fromARGB(255, 0, 0, 0),
      alignment: Alignment.topCenter,
    );
  }

  Widget _imageUser(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 25),
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () => registerController.showAlertDialog(context),
          child: GetBuilder<RegisterController>(
            builder: (value) => CircleAvatar(
              backgroundImage: registerController.imageFile != null
                  ? FileImage(registerController.imageFile!)
                  : null,
              radius: 80,
              backgroundColor: Colors.white,
              child: registerController.imageFile == null
                  ? Lottie.network(
                      'https://lottie.host/6ae6ef26-efd4-4aaa-8b2d-a4a79546b256/AN77OifYfo.json',
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonBack() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.only(left: 20),
      child: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 30,
        ),
      ),
    ));
  }
}
