import 'package:dio/dio.dart';
import 'package:invia_case_study/features/network/connectivity/connectivity_checker.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';

class ConnectivityInterceptor extends Interceptor {
  ConnectivityChecker connectivityChecker = ConnectivityChecker();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isOnline = await connectivityChecker
        .isOnline()
        .timeout(const Duration(seconds: 30));
    if (isOnline == false) {
      handler.reject(NoConnectivityException(options));
    } else {
      handler.next(options);
    }
  }
}
