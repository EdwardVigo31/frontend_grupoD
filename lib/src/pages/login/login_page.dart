import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 50,
        child: _textDontHaveAccount(),
      ),
      body: Stack(
        children: [
          _backgroundMainImage(context),
          _blackBackground(),
          _loginForm(context),
          Column(
            children: [
              _mainImage(),
              const SizedBox(height: 50),
              _mainImageTitle(),
            ],
          )
        ],
      ),
    );
  }

  Widget _mainImage() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 2),
        alignment: Alignment.center,
        child: Lottie.network(
          'https://lottie.host/bfad999d-6747-4f3e-94c5-3aeb0793f497/wINXszvwhi.json',
          width: 300,
          height: 300,
        ),
      ),
    );
  }

  Widget _mainImageTitle() {
    return Transform.translate(
      offset: const Offset(0, -60),
      child: const Text(
        'RAMADITA',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 255, 255, 255)),
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

  Widget _blackBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
    );
  }

  Widget _textDontHaveAccount() {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '¿No tienes cuenta? ',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => loginController.goToRegisterPage(),
            child: const Text(
              ' Regístrate Aquí',
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
            ),
          )
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 400), // Ajusta este valor según sea necesario
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.transparent, // Hacer el contenedor transparente
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textFieldEmail(),
              const SizedBox(height: 20),
              _textFieldPassword(),
              const SizedBox(height: 20),
              _buttonLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return TextField(
      controller: loginController.emailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.white), // Estilo del texto
      decoration: const InputDecoration(
        hintText: 'Correo electrónico',
        hintStyle: TextStyle(color: Colors.white70), // Estilo del hint
        prefixIcon: Icon(Icons.email, color: Colors.white), // Color del icono
        filled: true,
        fillColor: Color.fromARGB(99, 0, 0, 0), // Fondo semitransparente
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              color: Color.fromARGB(255, 44, 44, 44)), // Borde blanco
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              color: Color.fromARGB(255, 66, 66, 66)), // Borde blanco
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return TextField(
      controller: loginController.passwordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      style: const TextStyle(color: Colors.white), // Estilo del texto
      decoration: const InputDecoration(
        hintText: 'Contraseña',
        hintStyle: TextStyle(color: Colors.white70), // Estilo del hint
        prefixIcon: Icon(Icons.lock, color: Colors.white), // Color del icono
        filled: true,
        fillColor: Colors.transparent, // Fondo transparente
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              color: Color.fromARGB(255, 37, 37, 37)), // Borde blanco
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              color: Color.fromARGB(255, 61, 61, 61)), // Borde blanco
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: ElevatedButton(
        onPressed: () => loginController.login(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Aquí defines el color rojo del botón
            padding: const EdgeInsets.symmetric(vertical: 18)),
        child: const Text(
          'INGRESAR',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }
}
