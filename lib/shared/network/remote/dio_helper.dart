import 'package:dio/dio.dart';

//baseUrl: https://newsapi.org/
// method: v2/everything?
// query: q=tesla&from=2022-07-11&sortBy=publishedAt&apiKey=API_KEY


class DioHelper
{
  static Dio? dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      )
    );
  }

  static Future<Response?> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token
}) async
  {
    dio?.options.headers =
    {
      'content-Type':'application/json',
      'lang' : lang,
      'Authorization' : token??'',
    };

    return await dio?.get(
      url,
      queryParameters: query??null,

    ) ?? null;
  }

  static Future<Response<dynamic>?> postData({
    required url,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token
}) async
  {
    dio?.options.headers =
    {
      'content-Type':'application/json',
      'lang' : lang,
      'Authorization' : token??'',
    };


    return  dio?.post(
      url,
      queryParameters: query,
      data: data,
    ) ?? null;
  }


  static Future<Response<dynamic>?> putData({
    required url,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token
  }) async
  {
    dio?.options.headers =
    {
      'content-Type':'application/json',
      'lang' : lang,
      'Authorization' : token??'',
    };


    return  dio?.put(
      url,
      queryParameters: query,
      data: data,
    ) ?? null;
  }
}