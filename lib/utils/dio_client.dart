import 'package:data_karyawan/utils/config.dart';
import 'package:dio/dio.dart';

class DioClient {
  DioClient._();

  static final instance = DioClient._();

  factory DioClient() {
    return instance;
  }

  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: Config.API_URL,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        contentType: "application/json",
        responseType: ResponseType.plain),
  );

  ///Get Method
  Future<Map<String, dynamic>> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  //Post Method
  Future<Map<String, dynamic>> post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 204) {
        if (response.data is String) {
          return {"message": response.data};
        } else {
          return response.data;
        }
      } else if (response.data['values'] != null) {
        var msg = "";
        for (var item in response.data['values']) {
          msg += item['message'];
        }
        throw msg;
      }
      throw "something went wrong";
    } catch (e, t) {
      print(e);
      print(t);
      rethrow;
    }
  }
}
