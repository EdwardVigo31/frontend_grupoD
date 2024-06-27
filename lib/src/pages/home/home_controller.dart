import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/user.dart';

class HomeController extends GetxController{
  User user = User.fromJson(GetStorage().read('user')??{});
  HomeController(){
    print('Usuario de session: ${user.toJson()}');
  }

  void signOut(){
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
}