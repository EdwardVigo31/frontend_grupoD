import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto/src/providers/users_provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../../../models/response_api.dart';
import '../../../../models/user.dart';
import '../info/client_profile_info_controller.dart';

class ClientProfileUpdateController extends GetxController {
  User user = User.fromJson(GetStorage().read('user'));
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  UserProvider userProvider = UserProvider();

  Future selectImage(imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  ClientProfileInfoController clientProfileInfoController = Get.find();
  ClientProfileUpdateController() {
    emailController.text = user.email ?? '';
    nameController.text = user.name ?? '';
    lastnameController.text = user.lastname ?? '';
    phoneController.text = user.phone ?? '';
    passwordController.text = user.password ?? '';
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text(
          'GALERIA',
          style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
        ));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text(
          'Camara',
          style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
        ));
    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opcion'),
      actions: [galleryButton, cameraButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  Future<void> updateInfo(BuildContext context) async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();

    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.show(max: 100, msg: 'Actualizando datos...');

    User myUser = User(
      id: user.id,
      email: email,
      name: name,
      lastname: lastname,
      phone: phone,
      password: password,
      sessionToken: user.sessionToken,
      roles: user.roles,
    );
    if (imageFile == null) {
      ResponseApi responseApi = await userProvider.update(myUser);
      print('Response Api update: ${responseApi.data}');
      Get.snackbar('Proceso terminado', responseApi.message ?? '');
      progressDialog.close();
      if (responseApi.success == true) {
        GetStorage().write('user', responseApi.data);
        clientProfileInfoController.user.value =
            User.fromJson(GetStorage().read('user') ?? {});
      }
    } else {
      Stream stream = await userProvider.updateWithImage(myUser, imageFile!);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        Get.snackbar('Proceso terminado', responseApi.message ?? '');
        print('Response Api update: ${responseApi.data}');
        if (responseApi.success == true) {
          GetStorage().write('user', responseApi.data);
          clientProfileInfoController.user.value =
              User.fromJson(GetStorage().read('user') ?? {});
        } else {
          Get.snackbar('Registro fallido', responseApi.message ?? '');
        }
      });
    }
  }
}
