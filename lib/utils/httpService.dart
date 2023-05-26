import 'package:dio/dio.dart';

class HttpService {
  Dio? _dio;

  Future<HttpService> init(BaseOptions options) async {
    _dio = Dio(options);
    return this;
  }

  Future<dynamic> request(
      {required String endpoint, FormData? formData}) async {
    Response response;

    try {
      response = await _dio!.post(endpoint, data: formData);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      print(e);
      throw Exception("Something went wrong");
    }
  }

  Future<dynamic> requestPost(
      {required String endpoint, Map<String, Object>? param}) async {
    Response response;

    try {
      response = await _dio!.post(endpoint, data: param);
      print(response);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      print(e);
      throw Exception("Something went wrong");
    }
  }
}
