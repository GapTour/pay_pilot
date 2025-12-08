import 'package:dio/dio.dart';

class ErrorResponse {
  final String message;
  final String status;
  final int code;
  final String data;

  ErrorResponse({
    required this.message,
    required this.status,
    required this.code,
    required this.data,
  });

  factory ErrorResponse.fromMap(DioException e) {
    if ((e.response?.statusCode ?? 1000) > 500 ||
        e.response?.data is! Map<String, dynamic>) {
      return ErrorResponse(
        message: 'default error response',
        status: 'Failure',
        code: e.response?.statusCode ?? 520,
        data: 'Something went wrong!',
      );
    }

    final Map<String, dynamic> map = e.response?.data ?? {};

    return ErrorResponse(
      message: map['message'] ?? '',
      status: map['status'] ?? '',
      code: map['code'] ?? 0,
      data: map['data'] ?? '',
    );
  }

  factory ErrorResponse.defaultError(String? message, [int? statusCode]) {
    return ErrorResponse(
      message: 'default error response',
      status: 'Failure',
      code: statusCode ?? 600,
      data: message ?? 'Something went wrong!',
    );
  }

  @override
  String toString() {
    return 'ErrorResponse(message: $message, status: $status, code: $code, data: $data)';
  }
}
