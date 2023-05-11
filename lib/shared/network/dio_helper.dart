import 'package:dio/dio.dart';
class DioHelper{
 static Dio? dio;
  static init(){
    dio = Dio(
     BaseOptions(
      baseUrl: 'https://newsapi.org/',
     )
    );
  }

 static dynamic get(String endPoint,dynamic params) async
  {

   return await dio!.get(endPoint,queryParameters: params);
  }
}