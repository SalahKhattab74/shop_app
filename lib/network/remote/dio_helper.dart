import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
static Dio dio;
  static init (){
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: 'https://student.valuxapps.com/api/',
      )
    );
  }
static Future<Response> getData({
  @required String url,
  Map<String,dynamic>query,
  String language= 'en',
  String token,
})async{
dio.options.headers= {
    'Content-Type':'application/json',
    'lang' : language,
    'Authorization':token??'',
};
return await dio.get(url,queryParameters: query??null);

  }
 static Future<Response> postDat({
   @required String url,
   Map<String,dynamic> query,
   @required Map<String,dynamic>data,
   String language= 'en',
   String token,
 }) async{
    dio.options.headers={
      'Content-Type':'application/json',
      'lang':language,
   'Authorization':token??'',
    };
    return dio.post(url,queryParameters: query??null,data: data);
 }
static Future<Response> putData({
  @required String url,
  Map<String,dynamic> query,
  @required Map<String,dynamic>data,
  String language= 'en',
  String token,
}) async{
  dio.options.headers={
    'Content-Type':'application/json',
    'lang':language,
    'Authorization':token??'',
  };
  return dio.put(url,queryParameters: query??null,data: data);
}
}