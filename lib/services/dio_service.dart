import 'dart:io';

import 'package:altin_fiyatlari/model/dio_response.dart';
import 'package:dio/dio.dart';

enum Method { get, post, put, delete }

class DioService {
  static final DioService _singleton = DioService._internal();

  factory DioService() {
    return _singleton;
  }

  DioService._internal() {
    init();
  }

  Dio dio = Dio();

  void init() {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    String token = '6L3mJaBZdRied46irK08NHNDAPPVSpTHmpyLkDLMYmvCqdXVyi509vtwUigR';
    // headers.addAll({'Authorization': 'Bearer $token'});
    dio.options.baseUrl = 'https://www.nosyapi.com/apiv2/';
    dio.options.headers = headers;
  }

  Future<DioResponse> request(
    String path, {
    Method method = Method.get,
    Options? options,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    try {
      Response response;
      switch (method) {
        case Method.get:
          response = await dio.get(
            path,
            options: options,
            data: data,
            queryParameters: queryParameters,
            onReceiveProgress: onReceiveProgress,
          );
          break;

        case Method.post:
          response = await dio.post(
            path,
            options: options,
            data: data,
            queryParameters: queryParameters,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
          );
          break;

        case Method.put:
          response = await dio.put(
            path,
            options: options,
            data: data,
            queryParameters: queryParameters,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
          );
          break;

        case Method.delete:
          response = await dio.delete(
            path,
            options: options,
            data: data,
            queryParameters: queryParameters,
          );
          break;

        default:
          response = await dio.get(
            path,
            options: options,
            data: data,
            queryParameters: queryParameters,
            onReceiveProgress: onReceiveProgress,
          );
          break;
      }

      return DioResponse(data: response.data, isSuccessful: true, statusCode: response.statusCode ?? 0, message: 'Success');
    } on SocketException catch (e) {
      return DioResponse(data: {}, isSuccessful: false, statusCode: 0, message: 'SocketException: ${e.message}');
    } on DioError catch (e) {
      return DioResponse(data: {}, isSuccessful: false, statusCode: e.response?.statusCode ?? 0, message: e.message ?? 'DioError');
    } on Exception catch (e) {
      return DioResponse(data: {}, isSuccessful: false, statusCode: 0, message: 'Exception: ${e.toString()}');
    }
  }
}
