import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

class NetworkHelper {
  Dio? dio;
  NetworkHelper() {
    if (dio == null) {
      final BaseOptions options = BaseOptions(
        baseUrl: "",
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      );

      dio = Dio(options);
    }
  }

  Future<Response> getWithParams(
      {required String url, Map<String, dynamic>? parameterMap}) async {
    print('URL in get:$url');
    print('Params map in get:$parameterMap');

    Response response = await dio!.get(url,
        queryParameters: parameterMap,
        options: Options(headers: {
          "Connection": "Keep-Alive",
        }));
    print('URL:  ${response.realUri}');
    try {
      print('Response:$response');
      print('Get: ${response.data}');
    } on DioException catch (e) {
      print('Network Helper Get Error: $e');
    }
    return response;
  }
//created by new
//   Future<Response> getWithAuthOnly({
//     required String url,
//     required String username,
//     required String password,
//   }) async {
//     print('URL in get:$url');
//     print(username);
//     print(password);
//     String basicAuth =
//         'Basic ${base64Encode(utf8.encode('$username:$password'))}'; // Replace with your actual username and password
//     print('Body:$basicAuth');
//
//     Response response = await dio!.get(url,
//         options: Options(headers: {
//           "Connection": "Keep-Alive",
//           "Authorization": basicAuth,
//         }));
//     print('URL122:  ${response.realUri}');
//     try {
//       print('Response:$response');
//       print('Get: ${response.data}');
//     } on DioException catch (e) {
//       print('Network Helper Get Error: $e');
//     }
//     return response;
//   }
//   Future<Response> getWithAuth({
//     required String url,
//     required String username,
//     required String password,
//   }) async {
//     print('🔵 [NetworkHelper] Starting request to: $url');
//     String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
//
//     try {
//       final response = await dio!.get(
//         url,
//         options: Options(headers: {
//           "Authorization": basicAuth,
//           "username": username,
//         }),
//       );
//       print('🟢 [NetworkHelper] Successful response:');
//       print('Status: ${response.statusCode}');
//       print('Data: ${response.data}');
//       print('Headers: ${response.headers}');
//       return response;
//     } on DioException catch (e) {
//       print('🔴 [NetworkHelper] Error occurred:');
//       print('Error Type: ${e.type}');
//       print('Error Message: ${e.message}');
//       print('Response Status: ${e.response?.statusCode}');
//       print('Response Data: ${e.response?.data}');
//
//       // Return a response even for errors
//       return Response(
//         requestOptions: RequestOptions(path: url),
//         statusCode: e.response?.statusCode ?? 404,
//         data: e.response?.data ?? {'detail': 'No coupon purchases found'},
//       );
//     }
//   }
  //created by abhijith
  Future<Response> getWithAuth({
    required String url,
    required String username,
    required String password,
  }) async {
    print('URL in get:$url');
    print(username);
    print(password);
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}'; // Replace with your actual username and password
    print('Body:$basicAuth');
    late Response response;
    try {
      response = await dio!.get(url,
          options: Options(headers: {
            "Authorization": basicAuth,
            "username": "$username" //changed in coupon count
          }));
      print('URL:  ${response.realUri}');
      print('Response:$response');
      print('Get: ${response.data}');
    } on DioException catch (e) {
      print('Network Helper Get Error: $e');
    }
    return response;
  }

  Future<Response> getWithAuthAndBody({
    required String url,
    required String username,
    required String password,
    Map<String, dynamic>? requestBody,
  }) async {
    print('URL in get:$url');
    print(username);
    print(password);
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}'; // Replace with your actual username and password
    print('Body:$basicAuth');
    late Response response;
    try {
      response = await dio!.get(
        url,
        data:
            requestBody, // Pass the request body as query parameters
        options: Options(headers: {
          "Authorization": basicAuth,
          "username": "$username" //changed in coupon count
        }),
      );
      print('URL:  ${response.realUri}');
      print('Response:$response');
      print('Get: ${response.data}');
    } on DioError catch (e) {
      if (e.response != null) {
        print('Network Helper Get Error: ${e.response!.statusCode}');
        print('Response data: ${e.response!.data}');
      } else {
        print('Network Helper Get Error: $e');
      }
    }
    return response;
  }

  Future<Response> post(String url) async {
    print('URL in POST:$url');
    final response = await dio!.post(url);
    try {
      print('Response:$response');
      print('Get: ${response.data}');
    } on DioException catch (e) {
      print('Network Helper Post Error: $e');
      rethrow;
    }
    return response;
  }

  Future<Response> postWithBody({
    //created by new
    required String url,
    dynamic body,
    Map<String, String>? headers,
    String? token,
  }) async {
    print('URL:$url');
    print('Body:$body');
    print("username :$headers");
    try {
      final response = await dio!.post(
        url,
        data: body,
        options: Options(
            headers: headers ??
                {
                  "Content-Type": "application/json",
                  "Authorization": "Bearer $token",
                }),
      );
      print('Response:$response');
      print('Get: ${response.data}');
      return response;
    } on DioException catch (e) {
      print("postWithBody catch${e.response?.statusCode}");
      print(e.response?.data);
      print(e.response?.extra);
      print(e.response?.extra);
      rethrow;
    }
  }
  // Future<dynamic> postWithBodyAuth({
  //   required String url,
  //   dynamic body,
  //   String? username,
  //   String? password,
  // }) async {
  //   try {
  //     final response = await dio!.post(
  //       url,
  //       data: body,
  //       options: Options(
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Authorization": "Basic ${base64Encode(utf8.encode('$username:$password'))}",
  //         },
  //       ),
  //     );
  //     return response; // Returns a Response object
  //   } on DioException catch (e) {
  //     // Return a consistent error map
  //     return {
  //       'error': true,
  //       'message': _parseDioError(e),
  //       'statusCode': e.response?.statusCode,
  //       'serverResponse': e.response?.data,
  //     };
  //   }
  // }
  //
  // String _parseDioError(DioException e) {
  //   if (e.response != null) {
  //     if (e.response!.statusCode == 500) {
  //       return "Server error: Please try again later";
  //     }
  //     return e.response?.data['message'] ?? e.message ?? 'Request failed';
  //   }
  //   return e.message ?? 'Network request failed';
  // }
  Future<dynamic> postWithBodyAuth({
    required String url,
    dynamic body,
    Map<String, String>? headers,
    String? token,
    String? username,
    String? password,
    bool? isFromPendingList,
  }) async {
    print('URL:$url');
    print('Body:$body');
    print('userName:$username');
    print('Password:$password');
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}'; // Replace with your actual username and password
    print('Body:$basicAuth');
    // await pendingRequestController.checkConnectivity();
    // print(
    //     "postWithBody ${pendingRequestController.isOnline.value} 33333333333333333333");

    // if (pendingRequestController.isOnline.value) {

    try {
      final response = await dio!.post(
        url,
        data: body,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "Authorization": basicAuth,
          "username": "$username"
        }),
      );
      print('Response:$response');
      print('Get: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        // Handle network-related errors (e.g., timeout, no internet)

        print('Network error: ${e.message}');
        return "offline";
      } else {
        // Handle other Dio errors
        print('Dio error: ${e.message}');
        print("postWithBody catch${e.response?.statusCode}");
        print(e.response?.data);
        print(e.response?.extra);
        rethrow;
      }
    }
  }

  Future<Response> putWithParams({
    required String url,
    Map<String, dynamic>? parameterMap,
    dynamic body,
    Map<String, String>? headers,
    String? token,
  }) async {
    print('URL in PUT: $url');
    print('Params map in PUT: $parameterMap');
    print('Body in PUT: $body');

    try {
      final response = await dio!.put(
        url,
        queryParameters: parameterMap,
        data: body,
        options: Options(
          headers: headers ??
              {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              },
        ),
      );

      print('Response in PUT: $response');
      print('Data in PUT: ${response.data}');
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print("PUT Request Error Status Code: ${e.response!.statusCode}");
        print("Error Data: ${e.response!.data}");
        print("Error Extra: ${e.response!.extra}");
      } else {
        print("Network Helper PUT Error: $e");
      }
      rethrow;
    }
  }

  Future<Response> putWithAuth({
    required String url,
    Map<String, dynamic>? parameterMap,
    dynamic body,
    Map<String, String>? headers,
    String? token,
    String? username,
    String? password,
  }) async {
    print('URL in PUT: $url');
    print(' $password: ${password}');
    print('Body in PUT: $body');
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('${username}:${password}'))}'; // Replace with your actual username and password
    print('Body:$basicAuth');
    try {
      final response = await dio!.put(
        url,
        data: body,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": basicAuth,
            "username": "$username"
          },
        ),
      );

      print('Response in PUT: $response');
      print('Data in PUT: ${response.data}');
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print("PUT Request Error Status Code: ${e.response!.statusCode}");
        print("Error Data: ${e.response!.data}");
        print("Error Extra: ${e.response!.extra}");
      } else {
        print("Network Helper PUT Error: $e");
      }
      rethrow;
    }
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? parameterMap,
    Map<String, String>? headers,
    String? token,
  }) async {
    print('URL in DELETE: $url');
    print('Params map in DELETE: $parameterMap');

    try {
      final response = await dio!.delete(
        url,
        queryParameters: parameterMap,
        options: Options(
          headers: headers ??
              {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              },
        ),
      );

      print('Response in DELETE: $response');
      print('Data in DELETE: ${response.data}');
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print("DELETE Request Error Status Code: ${e.response!.statusCode}");
        print("Error Data: ${e.response!.data}");
        print("Error Extra: ${e.response!.extra}");
      } else {
        print("Network Helper DELETE Error: $e");
      }
      rethrow;
    }
  }

  Future<Response> deleteWithAuth({
    required String url,
    required String username,
    required String password,
    Map<String, dynamic>? parameterMap,
    dynamic body, // Add a body parameter
  }) async {
    print('URL in DELETE with Auth: $url');
    print('Params map in DELETE: $parameterMap');
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}'; // Basic Auth header

    try {
      final response = await dio!.delete(
        url,
        queryParameters: parameterMap,
        data: body, // Pass the body in the request
        options: Options(
          headers: {
            "Authorization": basicAuth,
            "Content-Type": "application/json",
          },
        ),
      );

      print('Response in DELETE with Auth: $response');
      print('Data in DELETE with Auth: ${response.data}');
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print("DELETE Request Error Status Code: ${e.response!.statusCode}");
        print("Error Data: ${e.response!.data}");
        print("Error Extra: ${e.response!.extra}");
      } else {
        print("Network Helper DELETE Error: $e");
      }
      rethrow;
    }
  }


}

class MockResponse {
  final int statusCode;
  final String data;

  const MockResponse(this.statusCode, this.data);
}
