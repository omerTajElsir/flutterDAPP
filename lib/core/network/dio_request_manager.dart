import 'package:dio/dio.dart';
import 'i_api_request_manager.dart';

class DioRequestManager extends IApiRequestManager {
  static final _baseUrl = 'https://api1.binance.com';
  final _connectionTimeout = 50000;
  final _receiveTimeout = 30000;
  late Dio _dio;

  DioRequestManager() {
    BaseOptions options = new BaseOptions(
      baseUrl: "$_baseUrl",
      connectTimeout: _connectionTimeout,
      receiveTimeout: _receiveTimeout,
    );
    _dio = new Dio(options);
    setInterceptor();
  }

  void setInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers = {
            'Accept': 'application/json',
            'Content-Type': 'application/json; charset=UTF-8',
            'accept-charset': 'UTF-8',
          };
          return handler.next(options);
        },
        onResponse: (Response response, handler) async {
          print('----->>> $response');
          return handler.next(response);
        },
        onError: (DioError e, handler) async {
          switch (e.type) {
            case DioErrorType.connectTimeout:
              return handler.next(DioError(
                  response: e.response,
                  error: '${e.message}',
                  requestOptions: RequestOptions(
                      path:
                          "") //HandshakeException - SocketException //مشکل در برقراری اینترنت
                  ));
              break;
            case DioErrorType.other:
              return handler.next(DioError(
                  response: e.response,
                  error: '${e.message}',
                  requestOptions: RequestOptions(
                      path:
                          "") //HandshakeException - SocketException //مشکل در برقراری اینترنت
                  ));
              break;
            case DioErrorType.receiveTimeout:
              return handler.next(DioError(
                  response: e.response,
                  error: '${e.message}',
                  requestOptions: RequestOptions(
                      path:
                          "") //HandshakeException - SocketException //مشکل در برقراری اینترنت
                  ));
              break;

            case DioErrorType.cancel:
              return handler.next(DioError(
                  response: e.response,
                  error: '${e.message}',
                  requestOptions: RequestOptions(
                      path:
                          "") //HandshakeException - SocketException //مشکل در برقراری اینترنت
                  ));
              break;

            case DioErrorType.sendTimeout:
              return handler.next(DioError(
                  response: e.response,
                  error: '${e.message}',
                  requestOptions: RequestOptions(
                      path:
                          "") //HandshakeException - SocketException //مشکل در برقراری اینترنت
                  ));
              break;
            case DioErrorType.response:
              return handler.next(DioError(
                  response: e.response,
                  error: '${e.message}',
                  requestOptions: RequestOptions(
                      path:
                          "") //HandshakeException - SocketException //مشکل در برقراری اینترنت
                  ));
              break;
          }
          return handler.next(e);
        },
      ),
    );
  }

  @override
  Future<dynamic> getRequest(
      {required String path, required Map<String, dynamic> parameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: parameters);
      return response.data;
    } on DioError catch (e) {
      throw FormatException(e.message);
    }
  }

  @override
  Future<dynamic> postRequest(
      {required String path, Map<String, dynamic>? parameters, body}) async {
    try {
      final response = await _dio.post(path, data: body);
      print('------ $response');
      return response.data;
    } on DioError catch (e) {
      throw FormatException(e.message);
    }
  }
}
