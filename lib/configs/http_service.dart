import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HttpService {
  late Dio dio;
  late FlutterSecureStorage _storage;
  var _token;
  final baseUrl = "http://10.0.2.2:8080";

  HttpService() {
    _storage = new FlutterSecureStorage();
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );
    _initInterceptor(dio);
  }

  _initInterceptor(Dio dio) async {
    _storage = new FlutterSecureStorage();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          _token = await _storage.read(key: "userToken");
          if (_token != null)
            options.headers["Authorization"] = "Bearer $_token";
          return handler.next(options);
        },
      ),
    );
  }
}
