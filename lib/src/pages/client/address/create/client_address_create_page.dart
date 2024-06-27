import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto/src/pages/client/address/create/client_address_create_controller.dart';

class ClientAddressCreatePage extends StatelessWidget {
  ClientAddressClientController clientAddressCreateController =
      Get.put(ClientAddressClientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _backgroundMainImage(context),
        _squareBox(context),
        _textNewAddress(context),
        _iconBack()
      ],
    ));
  }

  Widget _squareBox(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.46,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.30, left: 50, right: 50),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.75))
          ]),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _sendYourInfo(),
            _textFieldAddress(),
            _textFieldNeighborhood(),
            _textFieldRefPoint(context),
            _buttonCreate(context)
          ],
        ),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: ElevatedButton(
          onPressed: () => clientAddressCreateController.createAddress(),
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18)),
          child: const Text(
            'CREAR DIRECCION',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          )),
    );
  }

  Widget _iconBack() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 15),
        child: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 30,
            )),
      ),
    );
  }

  Widget _textFieldAddress() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: clientAddressCreateController.addressController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          hintText: 'Dirección ',
          prefixIcon: Icon(Icons.location_on),
        ),
      ),
    );
  }

  Widget _textFieldNeighborhood() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: clientAddressCreateController.neighborhoodController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          hintText: 'Calle',
          prefixIcon: Icon(Icons.location_city),
        ),
      ),
    );
  }

  Widget _textFieldRefPoint(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        onTap: () => clientAddressCreateController.openGoogleMaps(context),
        controller: clientAddressCreateController.refPointController,
        autofocus: false,
        focusNode: AlwaysDisableFocusNode(),
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          hintText: 'Punto de referencia',
          prefixIcon: Icon(Icons.map),
        ),
      ),
    );
  }

  Widget _sendYourInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 30),
      child: const Text(
        'INGRESA ESTA INFORMACIÓN ',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget _backgroundMainImage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.38,
      color: const Color.fromARGB(255, 255, 255, 255),
      alignment: Alignment.topCenter,
    );
  }

  Widget _textNewAddress(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.only(top: 15),
          alignment: Alignment.topCenter,
          child: const Column(
            children: [
              Icon(
                Icons.location_on,
                size: 200,
                color: Color.fromARGB(221, 252, 0, 0),
              ),
            ],
          )),
    );
  }
}

class AlwaysDisableFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
