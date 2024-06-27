import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto/src/models/product.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/pages/restaurant/orders/detail/restaurant_orders_detail_controller.dart';
import 'package:proyecto/src/utils/relative_time_util.dart';
import 'package:proyecto/src/widgets/no_data_widget.dart';

class RestaurantOrdersDetailPage extends StatelessWidget {
  RestaurantOrdersDetailController con =
      Get.put(RestaurantOrdersDetailController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: Container(
            color: const Color.fromRGBO(245, 245, 245, 1),
            height: con.order.status == 'PAGADO'
                ? MediaQuery.of(context).size.height * 0.50
                : MediaQuery.of(context).size.height * 0.45,
            child: Column(
              children: [
                _dataDate(),
                _dataClient(),
                _dataAddress(),
                _dataDelivery(),
                _totalToPay(context),
              ],
            ),
          ),
          appBar: AppBar(
            iconTheme:
                const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
            title: Text(
              'ORDEN #${con.order.id}',
              style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          body: con.order.products!.isNotEmpty
              ? ListView(
                  children: con.order.products!.map((Product product) {
                    return _cardProduct(product);
                  }).toList(),
                )
              : Center(
                  child:
                      NoDataWidget(text: 'No hay ningun producto agregado aun'),
                ),
        ));
  }

  Widget _dataClient() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Cliente y Telefono'),
        subtitle: Text(
            '${con.order.client?.name ?? ''} ${con.order.client?.lastname ?? ''} - ${con.order.client?.phone ?? ''}'),
        trailing: const Icon(Icons.person),
      ),
    );
  }

  Widget _dataDelivery() {
    return con.order.status != 'PAGADO'
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListTile(
              title: const Text('Repartidor asignado'),
              subtitle: Text(
                  '${con.order.delivery?.name ?? ''} ${con.order.delivery?.lastname ?? ''} - ${con.order.delivery?.phone ?? ''}'),
              trailing: const Icon(Icons.delivery_dining),
            ),
          )
        : Container();
  }

  Widget _dataAddress() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Direccion de entrega'),
        subtitle: Text(con.order.address?.address ?? ''),
        trailing: const Icon(Icons.location_on),
      ),
    );
  }

  Widget _dataDate() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Fecha del pedido'),
        subtitle: Text(
            '${RelativeTimeUtil.getRelativeTime(con.order.timestamp ?? 0)}'),
        trailing: const Icon(Icons.timer),
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
        Divider(height: 1, color: Colors.grey[300]),
        con.order.status == 'PAGADO'
            ? Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 30, top: 10),
                child: const Text(
                  'ASIGNAR REPARTIDOR',
                  style:
                      TextStyle(fontStyle: FontStyle.italic, color: Colors.red),
                ),
              )
            : Container(),
        con.order.status == 'PAGADO'
            ? _dropDownDeliveryMen(con.users)
            : Container(),
        Container(
          margin: EdgeInsets.only(
              left: con.order.status == 'PAGADO' ? 30 : 37, top: 15),
          child: Row(
            mainAxisAlignment: con.order.status == 'PAGADO'
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text(
                'TOTAL: \S/. ${con.total.value}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              con.order.status == 'PAGADO'
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: ElevatedButton(
                          onPressed: () => con.updateOrder(),
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(15),
                              primary: Colors.redAccent),
                          child: const Text(
                            'DESPACHAR ORDEN',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          )),
                    )
                  : Container()
            ],
          ),
        )
      ],
    );
  }

  Widget _dropDownDeliveryMen(List<User> users) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      margin: const EdgeInsets.only(top: 15),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.red,
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: const Text(
          'Seleccionar repartidor',
          style: TextStyle(fontSize: 15),
        ),
        items: _dropDownItems(users),
        value: con.idDelivery.value == '' ? null : con.idDelivery.value,
        onChanged: (option) {
          print('Opcion seleccionada ${option}');
          con.idDelivery.value = option.toString();
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<User> users) {
    List<DropdownMenuItem<String>> list = [];
    users.forEach((user) {
      list.add(DropdownMenuItem(
        value: user.id,
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              child: FadeInImage(
                image: user.image != null
                    ? NetworkImage(user.image!)
                    : const AssetImage('assets/img/no-image.png')
                        as ImageProvider,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 50),
                placeholder: const AssetImage('assets/img/no-image.png'),
              ),
            ),
            const SizedBox(width: 15),
            Text(user.name ?? ''),
          ],
        ),
      ));
    });

    return list;
  }
}
