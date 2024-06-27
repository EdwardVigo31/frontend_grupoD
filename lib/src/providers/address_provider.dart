
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto/src/models/response_api.dart';

import '../models/address.dart';
import '../models/user.dart';
import '../pages/environment/environment.dart';

class AddressProvider extends GetConnect{
  String url = '${Environment.API_URL}api/address';
  User userSession = User.fromJson(GetStorage().read('user')??{});

  Future<List<Address>> findByUser(String idUser) async {
    Response response = await get(
        '$url/findByUser/$idUser',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    );
    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada',
          'tu usuario no tiene permitido leer esta información');
      return [];
    }
    List<Address> address = Address.fromJsonList(response.body);
    return address;
  }

  Future<ResponseApi> create(Address address) async {
    Response response = await post(
        '$url/create',
        address.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken?? ''
        }
    );
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

}