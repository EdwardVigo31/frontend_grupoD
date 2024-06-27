import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto/src/pages/client/profile/update/client_profile_update_controller.dart';

class ClientProfileUpdaPage extends StatelessWidget {
  ClientProfileUpdateController clientProfileUpdateController =
      Get.put(ClientProfileUpdateController());
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
            _buttonUpdate(context)
          ],
        ),
      ),
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: ElevatedButton(
        onPressed: () => clientProfileUpdateController.updateInfo(context),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          primary: Colors.red, // Cambia el color del botón a rojo
        ),
        child: const Text(
          'ACTUALIZAR',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white, // Texto en color blanco
          ),
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: clientProfileUpdateController.emailController,
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

  Widget _textFielPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: clientProfileUpdateController.passwordController,
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

  Widget _textFieldName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: clientProfileUpdateController.nameController,
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
        controller: clientProfileUpdateController.lastnameController,
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
        controller: clientProfileUpdateController.phoneController,
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
            onTap: () => clientProfileUpdateController.showAlertDialog(context),
            child: GetBuilder<ClientProfileUpdateController>(
              builder: (value) => CircleAvatar(
                backgroundImage: clientProfileUpdateController.imageFile != null
                    ? FileImage(clientProfileUpdateController.imageFile!)
                    : clientProfileUpdateController.user.image != null
                        ? NetworkImage(
                            clientProfileUpdateController.user.image!)
                        : AssetImage('assets/img/add-user.png')
                            as ImageProvider,
                radius: 80,
                backgroundColor: Colors.white,
              ),
            )),
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
