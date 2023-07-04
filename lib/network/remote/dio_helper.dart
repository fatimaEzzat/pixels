import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/constants.dart';



class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        validateStatus: (status) => true, //TODO: only in dev
        headers:{'Authorization':apiKey} ,
        connectTimeout: const Duration(seconds: 2),
        receiveTimeout: const Duration(seconds: 2),
        // 30 seconds
      ),
    );
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? query,
  }) async {
    try {
      Response res = await dio.get(
        endPoint,
        queryParameters: query,
      );
      if (res.statusCode != 401) {
        return res;
      } else {
        //401 UnAuthorized
        throw 'UnAuthorized';
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        throw
        "connection time_out";
      } else if (ex.type == DioExceptionType.receiveTimeout) {
        throw "receive time_out";
      } else {
        debugPrint('exType: ${ex.type}');
        throw 'checkNet';
      }
    }
  }

}
