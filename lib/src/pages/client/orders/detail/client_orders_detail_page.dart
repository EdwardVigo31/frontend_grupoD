import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto/src/models/product.dart';
import 'package:proyecto/src/pages/client/orders/detail/client_oders_detail_controller.dart';
import 'package:proyecto/src/utils/relative_time_util.dart';
import 'package:proyecto/src/widgets/no_data_widget.dart';

class ClientOrdersDetailPage extends StatelessWidget {
  ClientOrdersDetailController con = Get.put(ClientOrdersDetailController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: Container(
            color: Color.fromRGBO(245, 245, 245, 1),
            height: con.order.status == 'EN CAMINO'
                ? MediaQuery.of(context).size.height * 0.4
                : MediaQuery.of(context).size.height * 0.35,
            // padding: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                _dataDate(),
                _dataDelivery(),
                _dataAddress(),
                _totalToPay(context),
              ],
            ),
          ),
          appBar: AppBar(
            iconTheme:
                IconThemeData(color: const Color.fromARGB(255, 255, 255, 255)),
            title: Text(
              'ORDEN #${con.order.id}',
              style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          body: con.order.products!.isNotEmpty
              ? ListView(
                  children: con.order.products!.map((Product product) {
                    return _cardProduct(product);
                  }).toList(),
                )
              : Center(
                  child: NoDataWidget(text: 'No hay ningún producto agregado')),
        ));
  }

  Widget _dataDelivery() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Repartidor y Telefono'),
        subtitle: Text(
            '${con.order.delivery?.name ?? 'No Asignado'} ${con.order.delivery?.lastname ?? ''} - ${con.order.delivery?.phone ?? '###'}'),
        trailing: Icon(Icons.person),
      ),
    );
  }

  Widget _dataAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Direccion de entrega'),
        subtitle: Text(con.order.address?.address ?? ''),
        trailing: Icon(Icons.location_on),
      ),
    );
  }

  Widget _dataDate() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Fecha del pedido'),
        subtitle: Text(
            '${RelativeTimeUtil.getRelativeTime(con.order.timestamp ?? 0)}'),
        trailing: Icon(Icons.timer),
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(
            255, 225, 225, 225), // Color de fondo blanco para el contenedor
        borderRadius: BorderRadius.circular(8), // Border radius de 8
      ),
      padding: const EdgeInsets.all(8), // Padding interno de 8
      child: Row(
        children: [
          _imageProduct(product),
          const SizedBox(width: 25),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(
                  'Cantidad: ${product.quantity}',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold
                      fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageProduct(Product product) {
    return Container(
      height: 100,
      width: 100,
      // padding: EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage(
          image: product.image1 != null
              ? NetworkImage(product.image1!)
              : AssetImage('assets/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }

  Widget _totalToPay(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1, color: const Color.fromARGB(255, 189, 189, 189)),
        Container(
          margin: EdgeInsets.only(
              left: con.order.status == 'EN CAMINO' ? 30 : 37, top: 15),
          child: Row(
            mainAxisAlignment: con.order.status == 'EN CAMINO'
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text(
                'TOTAL: \S/. ${con.total.value}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              con.order.status == 'EN CAMINO'
                  ? _buttonGoToOrderMap()
                  : Container()
            ],
          ),
        )
      ],
    );
  }

  Widget _buttonGoToOrderMap() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
          onPressed: () => con.goToOrderMap(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(15), primary: Colors.redAccent),
          child: Text(
            'RASTREAR PEDIDO',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
