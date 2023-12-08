import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static Future<Dio> getDio(
      {ResponseType responseType = ResponseType.json,
      isPrintLog = false}) async {
    Dio dio = Dio();

    // ignore: no_leading_underscores_for_local_identifiers
    Duration _timeOut = const Duration(minutes: 1); // 1 min

    dio.options = BaseOptions(
        connectTimeout: _timeOut,
        receiveTimeout: _timeOut,
        responseType: responseType);

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseHeader: false,
        logPrint: (object) {
          if (isPrintLog) {
            if (kDebugMode) {
              print(object);
            }
          }
        },
      ));
    }

    return dio;
  }
}
