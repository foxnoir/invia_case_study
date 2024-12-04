import 'package:dio/dio.dart';
import 'package:invia_case_study/features/network/connectivity/connectivity_interceptor.dart';

class HttpClient {
  HttpClient({
    Duration timeout = const Duration(
      milliseconds: 60000,
    ),
    List<Interceptor> additionalInterceptors = const [],
  }) {
    dioClient = Dio();
    dioClient.options.connectTimeout = timeout;
    dioClient.options.receiveTimeout = timeout;
    dioClient.options.sendTimeout = timeout;
    dioClient.interceptors.add(ConnectivityInterceptor());
    dioClient.interceptors.addAll(additionalInterceptors);
    dioClient.interceptors.add(
      LogInterceptor(
        error: false,
        requestHeader: false,
        requestBody: true,
        request: false,
        responseHeader: false,
        responseBody: true,
      ),
    );
  }

  late Dio dioClient;

  void addInterceptor(Interceptor interceptor) {
    dioClient.interceptors.add(interceptor);
  }

  set globalHeaders(Map<String, dynamic> headers) {
    dioClient.options.headers = headers;
  }

  Map<String, dynamic> get globalHeaders => dioClient.options.headers;
}
