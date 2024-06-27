import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto/src/pages/client/profile/info/client_profile_info_controller.dart';

import '../../../../models/user.dart';

class ClientProfileInfoPage extends StatelessWidget {
  final ClientProfileInfoController clientProfileInfoController =
      Get.put(ClientProfileInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundMainImage(context),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundMainImage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.blueGrey,
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            _imageUser(context),
            const SizedBox(height: 10),
            _buildTextName(),
            _buildTextEmail(),
            _buildTextPhone(),
            const SizedBox(height: 20),
            _buttonUpdate(context),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildButtonSignOut(),
                const SizedBox(width: 16),
                _buildButtonRoles(),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _imageUser(BuildContext context) {
    return CircleAvatar(
      backgroundImage: clientProfileInfoController.user.value.image != null
          ? NetworkImage(clientProfileInfoController.user.value.image!)
          : const AssetImage('assets/img/add-user.png') as ImageProvider,
      radius: 60,
      backgroundColor: Colors.white,
    );
  }

  Widget _buildTextName() {
    return Text(
      '${clientProfileInfoController.user.value.name ?? ''} ${clientProfileInfoController.user.value.lastname ?? ''}',
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        clientProfileInfoController.user.value.email ?? '',
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildTextPhone() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        clientProfileInfoController.user.value.phone ?? '',
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
      child: ElevatedButton(
        onPressed: () {
          clientProfileInfoController.goToprofileUpdate();
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          primary: const Color.fromARGB(
              255, 255, 17, 0), // Aquí estableces el color de fondo del botón
        ),
        child: const Text(
          'EDITAR DATOS',
          style: TextStyle(
            fontSize: 20, // Ajusta el tamaño del texto
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildButtonSignOut() {
    return Container(
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () => clientProfileInfoController.signOut(),
        icon: Icon(
          Icons.power_settings_new,
          color: Colors.grey[600],
          size: 30,
        ),
      ),
    );
  }

  Widget _buildButtonRoles() {
    return Container(
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () => clientProfileInfoController.goToRoles(),
        icon: Icon(
          Icons.supervised_user_circle,
          color: Colors.grey[600],
          size: 30,
        ),
      ),
    );
  }
}
