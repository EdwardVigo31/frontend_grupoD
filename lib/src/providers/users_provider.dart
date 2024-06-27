
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/pages/environment/environment.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';
class UserProvider extends GetConnect {
  String url = '${Environment.API_URL}api/users';
User userSession = User.fromJson(GetStorage().read('user')??{});
  Future<Response> create(User user) async {
    Response response = await post(
        '$url/create',
        user.toJson(),
        headers: {
          'Content-Type': 'application/json'
        }
    );
    return response;
  }
  Future<ResponseApi> update(User user) async {
    Response response = await put(
        '$url/updateWithoutImage',
        user.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken?? '',
        }
    );
    if(response.body==null){
      Get.snackbar('Error', 'No se pudo actualizar la informacion');
      return ResponseApi();
    }
    if(response.statusCode==401){
      Get.snackbar('Error', 'No estas autorizado para realizar esta peticion');
      return ResponseApi();
    }
    ResponseApi responseApi =  ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<List<User>> findDeliveryMen() async {
    Response response = await get(
        '$url/findDeliveryMen',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    List<User> users = User.fromJsonList(response.body);

    return users;
  }
  Future<Stream> updateWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OLD,'/api/users/update');
    final request = http.MultipartRequest('PUT',uri);
    request.headers['Authorization']=userSession.sessionToken?? '';
    request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);

  }

  Future<Stream> createWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OLD,'/api/users/createWithImage');
    final request = http.MultipartRequest('POST',uri);
    request.files.add(http.MultipartFile(
      'image',
      http.ByteStream(image.openRead().cast()),
      await image.length(),
      filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);

  }


  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
        '$url/login',
        {
          'email': email,
          'password': password
        },
        headers: {
          'Content-Type': 'application/json'
        }
    );
    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la peticion');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
  Future<ResponseApi> updateNotificationToken(String id, String token) async {
    Response response = await put(
        '$url/updateNotificationToken',
        {
          'id': id,
          'token': token
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la informacion');
      return ResponseApi();
    }

    if (response.statusCode == 401) {
      Get.snackbar('Error', 'No estas autorizado para realizar esta peticion');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}