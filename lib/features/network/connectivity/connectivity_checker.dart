import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ConnectivityChecker {
  Future<bool> isOnline() async {
    try {
      if (kIsWeb) {
        return await _isConnectedForWeb();
      } else if (Platform.isIOS || Platform.isAndroid) {
        return await _isConnectedForAndroidAndIos();
      } else {
        throw UnsupportedError('Unsupported platform');
      }
    } catch (exception) {
      return false;
    }
  }

  Future<bool> _isConnectedForAndroidAndIos() async {
    final result = await InternetAddress.lookup('google.com')
        .timeout(const Duration(seconds: 30));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _isConnectedForWeb() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.isNotEmpty;
  }
}
