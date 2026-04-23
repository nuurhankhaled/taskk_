import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart'; // ✅ add this import

class DioFactory {
  DioFactory._();
  static Dio? dio;
  static Dio getDio(String baseUrl) {
    Duration timeOut = const Duration(seconds: 80);
    if (dio == null) {
      dio = Dio();
      dio!
        ..options.baseUrl = baseUrl
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioHeaders();
      _ignoreSSL();
      return dio!;
    } else {
      return dio!;
    }
  } // ✅ add this method

  static void _ignoreSSL() {
    (dio!.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  static void addDioHeaders() async {
    dio?.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ',
    };
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers = {'Authorization': 'Bearer $token'};
  }
}
