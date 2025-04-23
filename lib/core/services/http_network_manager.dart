import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

abstract class HttpMethods {
  static const String post = "POST";
  static const String get = "GET";
  static const String put = "PUT";
  static const String patch = "PATCH";
  static const String delete = "DELETE";
}

class HttpManager {
  final Dio _dio = Dio();

  String getMimeType(String path) {
    final ext = path.split('.').last.toLowerCase();
    switch (ext) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'application/octet-stream';
    }
  }

  Future<Map<String, dynamic>> restRequest({
    required String url,
    String method = HttpMethods.get,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final headersDefault = headers ?? {'accept': 'application/json'};

    dynamic requestBody = body;

    // Convert body to FormData if file exists
    if (body != null && body['file'] != null && body['file'] is File) {
      headersDefault['Content-Type'] = 'multipart/form-data';
      FormData formData = FormData();

      body.forEach((key, value) {
        if (key == 'hashtags' && value is List<String>) {
          String hashtagsJson = jsonEncode(value);
          print('📌 Sending hashtags as JSON: $hashtagsJson');
          formData.fields.add(MapEntry('hashtags', hashtagsJson));
        } else if (key == 'file' && value is File) {
          String mimeType = getMimeType(value.path);
          List<String> mimeTypeParts = mimeType.split('/');

          formData.files.add(MapEntry(
            'file',
            MultipartFile.fromFileSync(
              value.path,
              filename: value.path.split('/').last,
              contentType: MediaType(mimeTypeParts[0], mimeTypeParts[1]),
            ),
          ));
        } else {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      });

      print('📄 FormData fields:');
      for (var field in formData.fields) {
        print('   - ${field.key}: ${field.value}');
      }

      print('📄 FormData files:');
      for (var file in formData.files) {
        print('   - ${file.key}: ${file.value.filename}');
      }

      requestBody = formData;
    }

    try {
      print('🔹 Final Request URL: $url');
      print('🔹 Final Request Method: $method');
      print('🔹 Final Request Headers: $headersDefault');
      print(
          '🔹 Final Request Body: ${requestBody is FormData ? 'FormData instance' : requestBody}');

      Response response = await _dio.request(
        url,
        options: Options(method: method, headers: headersDefault),
        data: requestBody,
        queryParameters: queryParameters,
      );

      print('✅ Response Data: ${response.data}');

      return {
        'statusCode': response.statusCode,
        'statusMessage': response.statusMessage,
        'data': response.data,
      };
    } on DioException catch (e) {
      print('❌ Dio Error: ${e.message}');
      print('❌ Response data: ${e.response?.data}');

      return {
        'statusCode': e.response?.statusCode,
        'statusMessage': e.response?.statusMessage ?? e.message,
        'error': e.message,
        'data': e.response?.data,
      };
    } catch (e) {
      print('❌ Unexpected Error: $e');
      return {
        'error': e.toString(),
      };
    }
  }
}
