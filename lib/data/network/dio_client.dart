import 'package:dio/dio.dart';

final dio = Dio(baseOptions);

BaseOptions baseOptions = BaseOptions(
  // baseUrl: "https://test-backend-flutter.surfstudio.ru/client/client.html",
  baseUrl: "https://jsonplaceholder.typicode.com",
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 5000,
  responseType: ResponseType.json,
);

Future<dynamic> getPosts() async {
  initInterceptors();
  final postResponse = await dio.get("/users");
  if (postResponse.statusCode == 200) return postResponse.data;
  throw Exception("HTTP request error. Error code ${postResponse.statusCode}");
}

void initInterceptors() {
  dio.interceptors.add(InterceptorsWrapper(
    onError: (err, handler) {
      print(
          'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

      throw Exception(
          'В запросе ${err.requestOptions.path} возникла ошибка: ${err.response?.statusCode ?? 0} ${err.response?.statusMessage ?? 'Unknown network error'}');
    },
    onRequest: (options, handler) {
      print(
          'REQUEST => {\n\t Method: ${options.method}\n\t PATH: ${options.path}\n\t HEADERS: ${options.headers}\n\t DATA: ${options.data}\n\t}');
      return handler.next(options);
    },
    onResponse: (response, handler) {
      print(
          'RESPONSE[${response.statusCode}] => {\n\t PATH: ${response.requestOptions.path}\n\t Data: ${response.data}\n\t}');
      return handler.next(response);
    },
  ));
}
