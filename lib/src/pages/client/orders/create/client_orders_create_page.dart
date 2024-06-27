import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto/src/models/product.dart';
import 'package:proyecto/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:proyecto/src/widgets/no_data_widget.dart';

class ClientOrdersCreatePage extends StatelessWidget {
  ClientOrdersCreateController clientOrdersCreateController =
      Get.put(ClientOrdersCreateController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: Container(
            color: Color.fromARGB(255, 0, 0, 0),
            height: 100,
            child: _totalToPay(context),
          ),
          appBar: AppBar(
            iconTheme:
                const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
            title: const Text(
              'Mi Orden',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          body: Container(
            color: const Color.fromARGB(
                255, 225, 225, 225), // Fondo rojo para todo el body
            child: clientOrdersCreateController.selectProducts.length > 0
                ? ListView(
                    children: clientOrdersCreateController.selectProducts
                        .map((Product product) {
                      return _cardProduct(product);
                    }).toList(),
                  )
                : Center(
                    child: NoDataWidget(
                      text: 'No hay ningun producto agregado aún',
                    ),
                  ),
          ),
        ));
  }

  Widget _buttonsAddOrRemove(Product product) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => clientOrdersCreateController.removeItem(product),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8))),
            child: const Text('-'),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          color: Colors.grey[200],
          child: Text('${product.quantity ?? 0}'),
        ),
        GestureDetector(
          onTap: () => clientOrdersCreateController.addItem(product),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: const Text('+'),
          ),
        ),
      ],
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Color de fondo blanco para el contenedor
        borderRadius: BorderRadius.circular(8), // Border radius de 8
      ),
      padding: const EdgeInsets.all(8), // Padding interno de 8
      child: Row(
        children: [
          _imageProduct(product),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 7),
                _textPrice(product),
                const SizedBox(height: 7),
                _buttonsAddOrRemove(product),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _iconDelete(product),
        ],
      ),
    );
  }

  Widget _totalToPay(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[400]),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total: S/${clientOrdersCreateController.total.value}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white, // Aquí estableces el color blanco
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () =>
                      clientOrdersCreateController.goToAddressList(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    primary: const Color.fromARGB(
                        255, 255, 43, 28), // Aquí estableces el color rojo
                  ),
                  child: const Text(
                    'CONFIRMAR ORDEN',
                    style: TextStyle(
                      color:
                          Colors.white, // Texto en color blanco para contraste
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _iconDelete(Product product) {
    return IconButton(
      onPressed: () => clientOrdersCreateController.deleteItem(product),
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      iconSize: 40.0, // Ajusta este valor según el tamaño que desees
    );
  }

  Widget _textPrice(Product product) {
    return Text(
      '\$${(product.price! * product.quantity!).toStringAsFixed(2)}',
      style: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.bold,
          fontSize: 16),
    );
  }

  Widget _imageProduct(Product product) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage(
          image: product.image1 != null
              ? NetworkImage(product.image1!)
              : const AssetImage('assets/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 50),
          placeholder: const AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }
}
