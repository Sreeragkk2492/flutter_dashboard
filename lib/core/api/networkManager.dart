import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_dashboard/core/api/apiHandlers.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/errors/error_object.dart';
import 'package:flutter_dashboard/core/view_models/token_management.dart';

class NetWorkManager extends APIHandler {
  static NetWorkManager? _shared;
  var dio = Dio();
  NetWorkManager._();

  static NetWorkManager shared() => _shared ?? NetWorkManager._();

  Future<Either<ErrorObject, Map<String, dynamic>>> request({
    required String url,
    String? method,
    Encoding? encodingType,
    Map<String, String>? params,
    bool isAuthRequired = true,
    Map<String, dynamic>? data,
    int? timeoutInSec,
  }) async {
    try {
      Map<String, String> header = {
        // 'Cookie':
        //     "PHPSESSID=${cookie.isNotEmpty ? cookie : "9er32rrs1mnvo60b5mc843qs51"}",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      if (isAuthRequired) {
        header["Authorization"] = "Bearer $token";
      }

      dio.options.headers = header;

      if (method == "put") {
       dio.options.headers["Content-Type"] = "application/json"; 
      }

      Response response;

      if (method == "post") {
        response = await dio
            .post(url,
                queryParameters: params, data: jsonEncode(data ?? {}))
            .timeout(Duration(seconds: timeoutInSec ?? 10));
      } else if (method == "put") {
        response = await dio
            .put(url, queryParameters: params,data: jsonEncode(data ?? {}))
            .timeout(Duration(seconds: timeoutInSec ?? 10));
      } else if (method == "delete") {
        response = await dio
            .delete(url)
            .timeout(Duration(seconds: timeoutInSec ?? 10));
      } else {
        response = await dio
            .get(url, queryParameters: params,)
            .timeout(Duration(seconds: timeoutInSec ?? 10));
      }

      final result = returnResponse(response);

      if (result["message"] == "AUTHENTICATION FAILED") {
        // Trigger token refresh
        final tokenRefreshResult = await tokenManagement();

        if (tokenRefreshResult) {
          // Retry the original request after successful token refresh
          return request(
            url: url,
            method: method,
            encodingType: encodingType,
            params: params,
            isAuthRequired: isAuthRequired,
            data: data,
            timeoutInSec: timeoutInSec,
          );
        }
      }

      if (result is Map<String, dynamic>) return Right(result);

      throw result;
    } catch (exception) {
      if (exception is DioException) {
        try {
          if (exception.error is SocketException) {
            return Left(ErrorObject.errorObject(
                exception: const SocketException("Network error!")));
          }

          if (exception.response == null) {
            return Left(ErrorObject.errorObject(exception: exception));
          }

          final result = returnResponse(exception.response!);

          return Left(ErrorObject.errorObject(exception: result));
        } catch (e) {
          return Left(ErrorObject.errorObject(exception: e));
        }
      }

      return Left(ErrorObject.errorObject(exception: exception));
    }
  }
}