import 'package:dio/dio.dart';

class ApiService {
  String BASE_URL="https://64088dcf2f01352a8a965e74.mockapi.io/";
  static String PRODUCTS = "products";
  Dio dio = Dio();


  Future<Response?> GET(String api) async {
    Response response = await dio.get(BASE_URL + api);
    if(response.statusCode==200) {
      return response;
    } else {
      return null;
    }
  }

}