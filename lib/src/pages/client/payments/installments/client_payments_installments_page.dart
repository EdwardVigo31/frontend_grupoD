import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto/src/models/mercado_pago_installment.dart';

import 'client_payments_installments_controller.dart';

class ClientPaymentsInstallmentsPage extends StatelessWidget {
  ClientPaymentsInstallmentsController con =
      Get.put(ClientPaymentsInstallmentsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: Container(
            color: Color.fromRGBO(245, 245, 245, 1),
            height: 100,
            child: _totalToPay(context),
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'Coutas',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textDescription(),
              _dropDownWidget(con.installmentsList)
            ],
          ),
        ));
  }

  Widget _textDescription() {
    return Container(
      margin: EdgeInsets.all(30),
      child: Text(
        'En cuantas coutas?',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _dropDownWidget(List<MercadoPagoInstallment> installments) {
    print('Número de cuotas disponibles: ${installments.length}');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: DropdownButton<String>(
        underline: Container(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.red,
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: Text(
          'Seleccionar número de cuotas',
          style: TextStyle(fontSize: 15),
        ),
        items: _dropDownItems(installments),
        value: con.installments.value.isEmpty ? null : con.installments.value,
        onChanged: (String? option) {
          print('Opción seleccionada: $option');
          con.installments.value = option ?? '';
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(
      List<MercadoPagoInstallment> installments) {
    return installments.map((installment) {
      return DropdownMenuItem<String>(
        child: Text('${installment.installments}'),
        value: '${installment.installments}',
      );
    }).toList();
  }

  Widget _totalToPay(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[300]),
        Container(
          margin: EdgeInsets.only(left: 20, top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TOTAL: \$${con.total.value}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                    onPressed: () => con.createPayment(),
                    style:
                        ElevatedButton.styleFrom(padding: EdgeInsets.all(15)),
                    child: Text(
                      'CONFIRMAR PAGO',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}
