import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto/src/models/order.dart';
import 'package:proyecto/src/pages/client/orders/list/client_orders_list_controller.dart';
import 'package:proyecto/src/utils/relative_time_util.dart';
import 'package:proyecto/src/widgets/no_data_widget.dart';

class ClientOrdersListPage extends StatelessWidget {
  ClientOrdersListController con = Get.put(ClientOrdersListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
          length: con.status.length,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black, Color.fromARGB(255, 0, 0, 0)],
                    ),
                  ),
                ),
                bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors
                      .white, // Color del indicador de la pestaña seleccionada
                  labelColor: Colors
                      .white, // Color del texto de la pestaña seleccionada
                  unselectedLabelColor: Colors.white.withOpacity(
                      0.7), // Color del texto de las pestañas no seleccionadas
                  tabs: List<Widget>.generate(con.status.length, (index) {
                    return Tab(
                      child: Text(
                        con.status[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }),
                ),
              ),
            ),
            body: TabBarView(
              children: con.status.map((String status) {
                return FutureBuilder(
                  future: con.getOrders(status),
                  builder: (context, AsyncSnapshot<List<Order>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.length > 0) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                            return _cardOrder(snapshot.data![index]);
                          },
                        );
                      } else {
                        return Center(
                          child: NoDataWidget(text: 'No hay órdenes'),
                        );
                      }
                    } else {
                      return const Center(
                        child:
                            CircularProgressIndicator(), // Muestra un indicador de carga mientras se obtienen los datos
                      );
                    }
                  },
                );
              }).toList(),
            ),
          ),
        ));
  }

  Widget _cardOrder(Order order) {
    return GestureDetector(
      onTap: () => con.goToOrderDetail(order),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.grey[100]!],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ORDEN #${order.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOrderDetail(Icons.calendar_today, 'PEDIDO:',
                      '${RelativeTimeUtil.getRelativeTime(order.timestamp ?? 0)}'),
                  const SizedBox(height: 10),
                  _buildOrderDetail(Icons.person, 'CLIENTE:',
                      '${order.client?.name ?? ''} ${order.client?.lastname ?? ''}'),
                  const SizedBox(height: 10),
                  _buildOrderDetail(Icons.location_on, 'UBICACIÓN DE ENTREGA:',
                      '${order.address?.address ?? ''}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetail(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.black), // Icono junto al título
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
