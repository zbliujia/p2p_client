import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import '../common/global.dart';

class HttpError implements Exception {
  HttpError({
    required this.errNo,
    required this.errMsg,
  });

  String errMsg;
  int errNo;

  String get message => errMsg;

  @override
  String toString() => errMsg;
}