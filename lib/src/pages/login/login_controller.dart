import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/providers/users_provider.dart';
import 'package:proyecto/src/models/user.dart';

class LoginController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserProvider userProvider = UserProvider();

  void goToRegisterPage(){
    Get.toNamed('/register');
  }
  void login() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();


    print('Email ${email}');
    print('Password ${password}');

    if(isValidForm(email,password)){
      ResponseApi responseApi = await userProvider.login(email, password);
      print('Response Api: ${responseApi.toJson()}');
      if(responseApi.success==true){
        GetStorage().write('user', responseApi.data);
        User myUser = User.fromJson(GetStorage().read('user')??{});
        print('Roles length:${myUser.roles!.length}');
        if(myUser.roles!.length > 1){
          goToRolesPage();
        }
        else{
          goToClientHomePage();
        }

      }
      else{
        Get.snackbar('Login fallido', responseApi.message ?? '');
      }
    }

  }
  void goToClientHomePage(){
    Get.offNamedUntil('/client/home', (route) => false);
  }
  void goToRolesPage(){
    Get.offNamedUntil('/roles', (route) => false);
  }

  bool isValidForm(String email, String password ){

    if(email.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el email.');
      return false;
    }
    if(!GetUtils.isEmail(email)){
      Get.snackbar('Formulario no valido', 'El email no es valido.');
      return false;
    }
    if(password.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el password.');
    }
    return true;
    }
}