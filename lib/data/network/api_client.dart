import 'package:dio/dio.dart';
import 'package:places/data/network/base_url.dart';

class ApiClient {
  static final _dio = createDio();

  static BaseOptions _baseOptions = BaseOptions(
    baseUrl: BaseUrl.host,
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 5),
    sendTimeout: Duration(seconds: 5),
    responseType: ResponseType.json,
  );

  static Dio createDio() {
    return Dio(_baseOptions);
  }

  static Dio getApiClient() => _dio
    ..interceptors.add(
      InterceptorsWrapper(
        onError: (DioError err, handler) {
          print(
              'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.baseUrl + err.requestOptions.path}\nERROR: ${err.error} -> ${err.response}');

          return handler.next(err);
        },
        onRequest: (options, handler) {
          print(
              'REQUEST => {\n\t Method: ${options.method}\n\t PATH: ${options.baseUrl + options.path}\n\t HEADERS: ${options.headers}\n\t DATA: ${options.data}\n\t}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print(
              'RESPONSE[${response.statusCode}] => {\n\t PATH: ${response.requestOptions.path}\n\t Data: ${response.data}\n\t}');
          return handler.next(response);
        },
      ),
    );
}


// Future<dynamic> getPosts() async {
//   initInterceptors();
//   final postResponse = await dio.get("/users");
//   if (postResponse.statusCode == 200) return postResponse.data;
//   throw Exception("HTTP request error. Error code ${postResponse.statusCode}");
// }

