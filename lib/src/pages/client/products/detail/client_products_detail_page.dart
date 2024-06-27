import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:proyecto/src/models/product.dart';
import 'package:proyecto/src/pages/client/products/detail/client_products_detail_controller.dart';

class ClientProductsDetailPage extends StatelessWidget {
  Product? product;
  late ClientProductsDetailController clientProductsDetailController;
  var counter = 0.obs;
  var price = 0.0.obs;
  ClientProductsDetailPage({@required this.product}) {
    clientProductsDetailController = Get.put(ClientProductsDetailController());
  }
  @override
  Widget build(BuildContext context) {
    clientProductsDetailController.checkIfProductsWasAdded(
        product!, price, counter);
    return Obx(() => Scaffold(
        bottomNavigationBar: Container(
            color: const Color.fromRGBO(245, 245, 245, 1.0),
            height: 100,
            child: _buttonsAddToBag()),
        body: Column(
          children: [
            _imageSlideshow(context),
            _TextNameProduct(),
            _TextDescriptionProduct(),
            _TextPriceProduct(),
          ],
        )));
  }

  Widget _imageSlideshow(BuildContext context) {
    return ImageSlideshow(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      initialPage: 0,
      indicatorColor: Colors.red,
      indicatorBackgroundColor: Colors.grey,
      children: [
        FadeInImage(
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 50),
            placeholder: const AssetImage('assets/img/no-image.png'),
            image: product!.image1 != null
                ? NetworkImage(product!.image1!)
                : const AssetImage('assets/img/no-image.png') as ImageProvider),
        FadeInImage(
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 50),
            placeholder: const AssetImage('assets/img/no-image.png'),
            image: product!.image2 != null
                ? NetworkImage(product!.image2!)
                : const AssetImage('assets/img/no-image.png') as ImageProvider),
        FadeInImage(
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 50),
            placeholder: const AssetImage('assets/img/no-image.png'),
            image: product!.image3 != null
                ? NetworkImage(product!.image3!)
                : const AssetImage('assets/img/no-image.png') as ImageProvider),
      ],
    );
  }

  Widget _TextNameProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product?.name ?? '',
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Color.fromARGB(255, 0, 0, 0)),
      ),
    );
  }

  Widget _TextDescriptionProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product?.description ?? '',
        style: const TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 164, 164, 164),
        ),
      ),
    );
  }

  Widget _buttonsAddToBag() {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[400]),
        Container(
          margin: const EdgeInsets.only(left: 30, right: 30, top: 25),
          child: Row(
            children: [
              ElevatedButton(
                  onPressed: () => clientProductsDetailController.removeItem(
                      product!, price, counter),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(45, 37),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25)))),
                  child: const Text(
                    '-',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 22),
                  )),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(45, 37)),
                child: Text(
                  '${counter.value}',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 22),
                ),
              ),
              ElevatedButton(
                onPressed: () => clientProductsDetailController.addItem(
                    product!, price, counter),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(45, 37),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25)))),
                child: const Text(
                  '+',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 22),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => clientProductsDetailController.addToBag(
                    product!, price, counter),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                child: Text(
                  'Agregar S/${price.value}',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _TextPriceProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 15, left: 30, right: 30),
      child: Text(
        'S/${product?.price.toString() ?? ''}',
        style: const TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
