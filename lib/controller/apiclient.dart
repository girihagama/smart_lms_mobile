
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ApiClient {
  //static String? url;
  static String bearerToken = '';
  static String baseURL = 
  // 'https://queue-man-api.24x7retail.com/api/';
  '';

  static Future<Response<dynamic>?> call(
    String endpoint,
    ApiMethod method, {
    FormData? formData,
    Map<String, dynamic>? data,
    bool errorToast = true,
    bool successToast = false,
    int successCode = 200,
    String? overrideUrl,
    bool authorized = true,
    bool showNoInternet = false,
  }) async {
    try {
      final BaseOptions dioOpt = BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 60), // 60 seconds
        receiveTimeout: const Duration(seconds: 60), //15 * 10000 as Duration
        // 60 seconds
      );
      final Dio dio = Dio(dioOpt);

      // var bytes = utf8
      //     .encode("6f4a3385-1550-4418-ae66-2434da862cde"); // data being hashed
      // var digest = sha1.convert(bytes);
      //debugPrint(digest.toString());

      final Options options = Options(
          followRedirects: false,
          validateStatus: (int? status) {
            return true;
          },
          headers: <String, dynamic>{}
          // headers: headers,
          );
      if (authorized) {
        options.headers?.putIfAbsent(
            HttpHeaders.authorizationHeader, () => 'Bearer $bearerToken');
      }

      final String uri = baseURL + endpoint;
      //'${overrideUrl ?? MyPOSConfig().server}$endpoint'.trim();
      // ignore: avoid_print
      // print(uri);
      dynamic tempFormData = data;
      if (formData != null) {
        tempFormData = formData;
        final Map<String, dynamic> temp = <String, dynamic>{};
        for (final MapEntry<String, String> e in formData.fields) {
          temp[e.key] = e.value;
        }
      }
      if (data != null) {
        tempFormData = jsonEncode(data);
        options.headers?.putIfAbsent(
            HttpHeaders.contentTypeHeader, () => 'application/json');
      }
      Response<dynamic> response;

      // if (showNoInternet) {
      //   if (!await MyPOSConfig().isConnected) {
      //     EasyLoading.showError('No Internet Connection');
      //     throw Exception('No internet connection');
      //   }
      // }
      switch (method) {
        case ApiMethod.GET:
          response = await dio.get(uri, data: tempFormData, options: options);
          break;
        case ApiMethod.POST:
          // FormData temp = formData??FormData.fromMap(data);
          response = await dio.post(uri, data: tempFormData, options: options);
          break;
        case ApiMethod.PUT:
          // FormData temp = formData??FormData.fromMap(data);
          response = await dio.put(uri, data: tempFormData, options: options);
          break;
        case ApiMethod.DELETE:
          response =
              await dio.delete(uri, data: tempFormData, options: options);
          break;
      }
      final dynamic result = response.data;
      // print(response);
      // print(result);
      // print(uri);

      if (response.statusCode == 401) {
        // await _getToken();
        return await call(endpoint, method,
            formData: formData,
            data: data,
            successCode: successCode,
            successToast: successToast,
            errorToast: errorToast);
      }

      if (response.statusCode != successCode) {
        if (errorToast) {
          if (result == null || result.toString().isEmpty) {
            EasyLoading.showToast('Invalid api response',
                toastPosition: EasyLoadingToastPosition.bottom);
          } else {
            final dynamic message =
                result == null ? '' : result?['message'] ?? '';
            if (message.toString().isNotEmpty) {
              EasyLoading.showToast(message,
                  toastPosition: EasyLoadingToastPosition.bottom);
            }
          }
        }
      } else {
        if (successToast) {
          EasyLoading.showToast(result['message'],
              toastPosition: EasyLoadingToastPosition.bottom);
        }
      }
      return response;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> _getToken() async {
    final Response<dynamic>? res = await call(
        'api/Login/regenerate_token', ApiMethod.POST,
        formData: FormData.fromMap(<String, dynamic>{'old_token': bearerToken}),
        authorized: false);
    bearerToken = res?.data['token'] ?? '';
  }

  void justErrorFix() {}
}

enum ApiMethod { GET, POST, PUT, DELETE }